resource "aws_sns_topic" "serv_status_chk_topic" {
  name = var.serv_status_chk_topic_name
}

resource "aws_sns_topic_subscription" "serv_status_chk_sub" {
  count                  = length(var.serv_status_chk_sns_email)
  topic_arn              = aws_sns_topic.serv_status_chk_topic.arn
  protocol               = "email"
  endpoint               = var.serv_status_chk_sns_email[count.index]
  endpoint_auto_confirms = true
}