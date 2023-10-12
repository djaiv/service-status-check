resource "aws_cloudwatch_event_rule" "serv_status_chk_event_rule" {
  name                = var.serv_status_chk_event_rule_name
  description         = "Rule to trigger SSM Run Command for service check status"
  schedule_expression = "rate(1 minute)" # Trigger every 1 minute
}

resource "aws_cloudwatch_event_target" "serv_status_chk_event_target" {
  arn      = aws_ssm_document.serv_status_chk_doc.arn
  rule     = aws_cloudwatch_event_rule.serv_status_chk_event_rule.name
  role_arn = aws_iam_role.serv_status_chk_event_role.arn

  run_command_targets {
    key    = "tag:Name" #This will be the Tag Key of EC2 Isntance you want Eventbridge to runCommand against, In this case it is Name
    values = ["${var.env}-apache-instance"] #This will be the Tag Value of EC2 Isntance you want Eventbridge to runCommand against, In this case it is the value of variable env-apache-instance
  }
}



