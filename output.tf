output "id" {
  value       = [for key, value in datadog_monitor.main : value.id]
  description = "List of Datadog Monitor IDs."
}