# Shared by: Tseno Stamenov
# Lists all Microsoft 365 / Entra ID groups including Security, Mail-enabled, Microsoft 365, and Distribution types.

Connect-MgGraph -Scopes "Group.Read.All"

Get-MgGroup -All |
Select DisplayName, Id, MailEnabled, SecurityEnabled |
Export-Csv "$env:USERPROFILE\Documents\All_Groups.csv" -NoTypeInformation -Encoding UTF8
