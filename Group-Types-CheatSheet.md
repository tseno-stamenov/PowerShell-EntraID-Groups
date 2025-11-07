# Group Types Cheat Sheet (Microsoft 365 / Entra ID)

## 🧭 Резюме

Този документ обобщава различните типове групи в Microsoft 365 / Entra ID (Azure AD) и техните основни разлики.  
Целта е бързо да се ориентираш по атрибутите `MailEnabled`, `SecurityEnabled` и `GroupTypes`,  
за да разбереш дали една група е Security, Distribution, Microsoft 365 (Unified) или Dynamic.  

Полезно за администратори, които работят с PowerShell, Microsoft Graph или Entra ID Portal  
и искат бърз начин да разпознаят кой тип група виждат в даден списък или CSV.

Тествал: Цено Стаменов  

---

## 📘 Как да ги различим накратко

| Тип група | MailEnabled | SecurityEnabled | GroupTypes | Какво значи |
|-----------|-------------|-----------------|-------------|-------------|
| **Security Group** | False | True | {} | За достъп и разрешения (файлове, приложения, Conditional Access) |
| **Mail-enabled Security** | True | True | {} | Има имейл + използва се и за достъп |
| **Distribution Group (DL)** | True | False | {} | Само за имейл дистрибуция (Exchange) |
| **Microsoft 365 Group (Unified)** | True | False | {Unified} | Teams / SharePoint / Planner / календар |
| **Dynamic Group** | any | зависи | {DynamicMembership} | Членството се управлява автоматично по правила (rules) |

> 💡 Бележка: DL и Mail-enabled Security групите често се извличат през **Exchange Online**  
> (`Get-DistributionGroupMember` или `Get-UnifiedGroupLinks`).

---

## ⚙️ Бърза проверка с PowerShell (Microsoft Graph)

```powershell
Connect-MgGraph -Scopes "Group.Read.All"

Get-MgGroup -Top 10 |
  Select DisplayName, MailEnabled, SecurityEnabled, GroupTypes
