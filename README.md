## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0 |
| <a name="requirement_datadog"></a> [datadog](#requirement\_datadog) | >= 3.23.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_datadog"></a> [datadog](#provider\_datadog) | >= 3.23.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [datadog_monitor.main](https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/monitor) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to deploy to. For example, dev, test, prod. | `string` | n/a | yes |
| <a name="input_monitors"></a> [monitors](#input\_monitors) | Map of monitors to create. | <pre>list(object({<br>    service_name             = string<br>    service_metric_name      = string<br>    application_name         = string<br>    type                     = string<br>    query                    = string<br>    contacts                 = optional(list(string), [])<br>    notify_pagerduty         = optional(bool, false)<br>    notify_pagerduty_service = optional(string, "")<br>    notify_no_data           = optional(bool, true)<br>    notify_audit             = optional(bool, false)<br>    require_full_window      = optional(bool, false)<br>    timeout_h                = optional(number, 0)<br>    evaluation_delay         = optional(number, 600)<br>    new_group_delay          = optional(number, 0)<br>    no_data_timeframe        = optional(number, 10)<br>    renotify_interval        = optional(number, 0)<br>    warning_message          = optional(string, "The service is now in warning state. Please investigate.")<br>    critical_message         = optional(string, "The service is now in critical state!")<br>    recovery_message         = optional(string, "The service has recovered.")<br>    no_data_message          = optional(string, "The service is not reporting any data!")<br>    escalation_message       = optional(string, "")<br>    tags                     = optional(list(string), [])<br>    include_tags             = optional(bool, false)<br>    monitor_thresholds = optional(object({<br>      warning           = optional(number, null)<br>      warning_recovery  = optional(number, null)<br>      critical          = optional(number, null)<br>      critical_recovery = optional(number, null)<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_pagerduty_handle"></a> [pagerduty\_handle](#input\_pagerduty\_handle) | PagerDuty handle to use for notifications. For example, @pagerduty | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all monitors. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | List of Datadog Monitor IDs. |
