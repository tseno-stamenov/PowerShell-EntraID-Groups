# Превод и обяснение на синтаксиса от Цено Стаменов
Connect-MgGraph -Scopes "Group.Read.All"
# Взима всички групи и изкарва ID 
Get-MgGroup -All | 
Select-Object DisplayName, Id |
Sort-Object DisplayName


# След въвеждане на командата, изкарва питане за ID в което въвеждате ID-то, или ако ще се ползва като цяла програма - предварително в .ps1 файла. 
# Exports all user members from a Microsoft 365 / Entra ID group to CSV (via Microsoft Graph).

Connect-MgGraph -Scopes "Group.Read.All,Directory.Read.All"

$GroupId = Read-Host "Enter Group Object ID"

$members = Get-MgGroupTransitiveMember -GroupId $GroupId -All |
Where-Object { $_.'@odata.type' -eq '#microsoft.graph.user' } |
Select-Object DisplayName, UserPrincipalName, Id

if ($members) {
    $file = "$env:USERPROFILE\Documents\Group_Members_$((Get-Date -Format yyyyMMdd_HHmm)).csv"
    $members | Export-Csv $file -NoTypeInformation -Encoding UTF8
    Write-Host "✅ Export complete! File saved to: $file" -ForegroundColor Green
} else {
    Write-Host "⚠️ No user members found in this group (might be empty or Distribution Group)." -ForegroundColor Yellow
}
