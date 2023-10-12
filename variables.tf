variable "serv_status_chk_sns_email" {
  type    = list(string)
  default = []
}

variable "serv_status_chk_topic_name" {
  type    = string
  default = ""
}

variable "serv_status_chk_event_rule_name" {
  type    = string
  default = ""
}

variable "serv_status_chk_doc_name" {
  type    = string
  default = ""
}

variable "serv_status_chk_event_role_name" {
  type    = string
  default = ""
}

variable "serv_status_chk_event_policy_name" {
  type    = string
  default = ""
}

variable "env" {
  type    = string
  default = ""
}

/*variable "aws_region" {
  type    = string
  default = ""
}*/
