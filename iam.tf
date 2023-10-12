resource "aws_iam_role" "serv_status_chk_event_role" {
  name = var.serv_status_chk_event_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "events.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "serv_status_chk_event_policy" {
  name = var.serv_status_chk_event_policy_name
  role = aws_iam_role.serv_status_chk_event_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssm:SendCommand",
        ]
        Effect = "Allow"
        Resource : [
          "arn:aws:ec2:${local.region}:${local.account_id}:instance/*",
          "arn:aws:ssm:${local.region}:*:document/${var.serv_status_chk_doc_name}"
        ]
      },
    ]
  })
}