# Configure a monitoring central account
resource "aws_oam_sink" "monitoring_account_oam_sink" {
  name = "ExampleSink"
}

resource "aws_oam_sink_policy" "monitoring_account_oam_sink_policy" {
  sink_identifier = aws_oam_sink.monitoring_account_oam_sink.id

  # See https://docs.aws.amazon.com/OAM/latest/APIReference/API_PutSinkPolicy.html for examples
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["oam:CreateLink", "oam:UpdateLink"]
        Effect   = "Allow"
        Resource = "*"
        Principal = {
          "AWS" = var.source_account_ids
        }
        Condition = {
          "ForAllValues:StringEquals" = {
            "oam:ResourceTypes" = ["AWS::CloudWatch::Metric"]
          }
        }
      }
    ]
  })
}







