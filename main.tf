resource "datadog_monitor" "main" {
  for_each = { for monitor in var.monitors : substr(md5("${md5(monitor.service_name)}-${md5(monitor.service_metric_name)}-${md5(monitor.application_name)}"), 0, 24) => monitor }

  name    = "${each.value.service_name} - ${each.value.service_metric_name} for ${each.value.application_name} (${var.environment})"
  type    = each.value.type
  query   = each.value.query
  message = <<-EOT
    ${each.value.service_name} - ${each.value.service_metric_name} for ${each.value.application_name}:
    {{#is_warning}}${each.value.warning_message}{{/is_warning}}
    {{#is_alert}}${each.value.critical_message} ${each.value.notify_pagerduty ? var.pagerduty_handle : ""}{{/is_alert}}
    {{#is_recovery}}${each.value.recovery_message} ${each.value.notify_pagerduty ? var.pagerduty_handle : ""}{{/is_recovery}}
    {{#is_no_data}}${each.value.no_data_message}{{/is_no_data}}
    ${each.value.contacts != [] ? "\n\nNotifcation sent to:\n${join(", ", each.value.contacts)}" : ""}
  EOT

  tags = concat(
    ["env:${var.environment}"],
    each.value.tags,
    try([for key, value in var.tags : "${key}:${value}"], {})
  )

  escalation_message  = each.value.escalation_message
  evaluation_delay    = each.value.evaluation_delay
  include_tags        = each.value.include_tags
  new_group_delay     = each.value.new_group_delay
  no_data_timeframe   = each.value.no_data_timeframe
  notify_audit        = each.value.notify_audit
  notify_no_data      = each.value.notify_no_data
  renotify_interval   = each.value.renotify_interval
  require_full_window = each.value.require_full_window
  timeout_h           = each.value.timeout_h

  dynamic "monitor_thresholds" {
    for_each = try(each.value.monitor_thresholds, null) != null ? [each.value.monitor_thresholds] : []
    iterator = m

    content {
      warning           = m.value.warning
      warning_recovery  = m.value.warning_recovery
      critical          = m.value.critical
      critical_recovery = m.value.critical_recovery
    }
  }
}
