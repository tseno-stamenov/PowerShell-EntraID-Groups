# Shared by: Tseno Stamenov
# Lists all groups with flattened GroupTypes and a readable Type column

Connect-MgGraph -Scopes "Group.Read.All"

Get-MgGroup -All |
Select-Object `
  DisplayName,
  MailEnabled,
  SecurityEnabled,
  @{Name='GroupTypes'; Expression={ ($_.GroupTypes -join ';') }},     # flatten array
  @{Name='Type'; Expression={
      if     ($_.GroupTypes -contains 'Unified')              {'M365 Group'}
      elseif ($_.GroupTypes -contains 'DynamicMembership')    {'Dynamic Group'}
      elseif ($_.MailEnabled -and  $_.SecurityEnabled)        {'Mail-enabled Security'}
      elseif ($_.MailEnabled -and -not $_.SecurityEnabled)    {'Distribution'}
      elseif (-not $_.MailEnabled -and $_.SecurityEnabled)    {'Security'}
      else                                                     {'Other'}
  }} |
Export-Csv "$env:USERPROFILE\Documents\Groups_Detailed.csv" -NoTypeInformation -Encoding UTF8
