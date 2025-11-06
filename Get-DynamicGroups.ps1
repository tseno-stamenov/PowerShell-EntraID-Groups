# Динамичните групи (Dynamic Groups) в Microsoft Entra ID / Azure AD автоматично добавят и премахват членове
# според зададени правила (Membership Rules) — например по отдел, длъжност, локация или друг атрибут.
# Те се различават от обикновените Security или M365 групи по това, че не се управляват ръчно, 
# а чрез логика като (user.department -eq "IT") или (user.country -eq "Bulgaria"). 
# Превод на синтаксис: Цено Стаменов

# Shared by: Tseno Stamenov
# Lists only Dynamic groups in Entra ID (Azure AD) and shows their membership rules.

Connect-MgGraph -Scopes "Group.Read.All,Directory.Read.All"

# Get dynamic groups (where GroupTypes contains 'DynamicMembership')
$dyn = Get-MgGroup -All `
  -Filter "groupTypes/any(c:c eq 'DynamicMembership')" `
  -Property "displayName,id,groupTypes,membershipRule,membershipRuleProcessingState"

# Show summary in console
$dyn | Select-Object DisplayName, Id,
  @{n='GroupTypes';e={$_.GroupTypes -join ';'}},
  MembershipRule,
  @{n='ProcessingState';e={$_.MembershipRuleProcessingState}} |
  Format-Table -AutoSize

# Export to CSV
$out = "$env:USERPROFILE\Documents\Dynamic_Groups_$((Get-Date -Format yyyyMMdd_HHmm)).csv"
$dyn | Select-Object DisplayName, Id,
  @{n='GroupTypes';e={$_.GroupTypes -join ';'}},
  MembershipRule,
  @{n='ProcessingState';e={$_.MembershipRuleProcessingState}} |
Export-Csv $out -NoTypeInformation -Encoding UTF8

Write-Host "✅ Found $($dyn.Count) dynamic groups. CSV saved: $out" -ForegroundColor Green

# Тествано от: Цено Стаменов
