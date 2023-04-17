variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all monitors."
}

variable "environment" {
  type        = string
  description = "The environment to deploy to. For example, dev, test, prod."
}

variable "pagerduty_handle" {
  type        = string
  default     = ""
  description = "PagerDuty handle to use for notifications. For example, @pagerduty"
}

variable "monitors" {
  type = list(object({
    service_name             = string
    service_metric_name      = string
    application_name         = string
    type                     = string
    query                    = string
    contacts                 = optional(list(string), [])
    notify_pagerduty         = optional(bool, false)
    notify_pagerduty_service = optional(string, "")
    notify_no_data           = optional(bool, true)
    notify_audit             = optional(bool, false)
    require_full_window      = optional(bool, false)
    timeout_h                = optional(number, 0)
    evaluation_delay         = optional(number, 600)
    new_group_delay          = optional(number, 0)
    no_data_timeframe        = optional(number, 10)
    renotify_interval        = optional(number, 0)
    warning_message          = optional(string, "The service is now in warning state. Please investigate.")
    critical_message         = optional(string, "The service is now in critical state!")
    recovery_message         = optional(string, "The service has recovered.")
    no_data_message          = optional(string, "The service is not reporting any data!")
    escalation_message       = optional(string, "")
    tags                     = optional(list(string), [])
    include_tags             = optional(bool, false)
    monitor_thresholds = optional(object({
      warning           = optional(number, null)
      warning_recovery  = optional(number, null)
      critical          = optional(number, null)
      critical_recovery = optional(number, null)
    }))
  }))
  description = "Map of monitors to create."
}