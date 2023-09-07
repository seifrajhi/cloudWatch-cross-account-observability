locals {
  names = [
    "CloudWatchReadOnlyAccess",
    "CloudWatchAutomaticDashboardsAccess",
    "AWSXrayReadOnlyAccess"
  ]
}

locals {
  policy = {
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : var.monitoring_account_id
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  }
}