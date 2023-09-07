# Configure a monitoring account

A source account is an individual AWS account that generates observability data for the resources in it. A monitoring account is the account that can view and interact with observability data generated from source accounts. Configuring the monitoring account requires us to configure a Sink and a Sink policy.

It is worth mentioning the following caveats:

- terraform version 1.x is required at minimum
- terraform AWS Provider 4.62.0 is required at minimum


```
cd oam-sink
```

Then Change `source_account_ids` with the list of source accounts in `vars.tf`

```
terraform init
terraform plan
terraform apply
```

Once applied, you should be able to verify in the AWS console that the monitoring account has been enabled.

# Configure source account(s)

For each source account you’ll need to:

- Create a link to the monitoring account
- Enable the `AWSServiceRoleForCloudWatchCrossAccount` role — which is created by CloudWatch when the monitoring account is enabled — in the monitoring account to assume the CloudWatch-CrossAccountSharingRole role in the source account.


```
cd oam-link
```
Then Change `monitoring_account_sink_identifier` with the monitoring account sink identifier ans `monitoring_account_id`  with the monitoring account id in `vars.tf`

```
terraform init
terraform plan
terraform apply
```

Once the above has been applied you can now go into your monitoring account and enter a source account number to see metrics from the source account