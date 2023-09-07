# Configure source account(s)
resource "aws_oam_link" "source_account_oam_link" {
  label_template  = "$AccountName"
  resource_types  = ["AWS::CloudWatch::Metric"]
  sink_identifier = var.monitoring_account_sink_identifier

  tags = {
    Env = "test"
  }
}



data "aws_iam_policy" "policy" {
  for_each = toset(local.names)
  name     = each.value
}




resource "aws_iam_role" "aws-cloudwatch-metrics-role" {
  name             = "CloudWatch-CrossAccountSharingRole"
  assume_role_policy = jsonencode(local.policy)
}

resource "aws_iam_role_policy_attachment" "policy" {
  for_each    = toset(local.names)
  policy_arn = data.aws_iam_policy.policy[each.key].arn
  role       = aws_iam_role.aws-cloudwatch-metrics-role.name
}
