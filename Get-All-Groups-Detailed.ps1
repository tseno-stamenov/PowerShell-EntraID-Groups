# Shared by: Tseno Stamenov
# Lists all groups with detailed properties like MailEnabled, SecurityEnabled, and GroupTypes for easier identification.

Connect-MgGraph -Scopes "Group.Read.All"

Get-MgGroup -All |
Select DisplayName, MailEnabled, SecurityEnabled, GroupTypes |
Export-Csv "$env:USERPROFILE\Documents\Groups_Detailed.csv" -NoTypeInformation -Encoding UTF8
