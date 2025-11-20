<#
    Active Directory Automated User Creation Script
    ------------------------------------------------
    Creates sample employees in different OUs using
    AD-compliant random passwords.

    For portfolio/github use.
#>

Import-Module ActiveDirectory

# -------------------------------
# Password Generator (Guaranteed AD Complexity)
# -------------------------------
function New-RandomPassword {
    # Required classes of characters
    $upper   = [char[]]'ABCDEFGHIJKLMNOPQRSTUVWXYZ' | Get-Random
    $lower   = [char[]]'abcdefghijklmnopqrstuvwxyz' | Get-Random
    $number  = [char[]]'0123456789' | Get-Random
    $special = [char[]]'!@#$%^&*()-_=+[]{}' | Get-Random
    
    # Remaining chars (to make 12 total)
    $allChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[]{}'
    $remaining = -join (1..8 | ForEach-Object { $allChars[(Get-Random -Minimum 0 -Maximum $allChars.Length)] })

    # Combine & shuffle so order is not predictable
    $password = "$upper$lower$number$special$remaining"
    $password = -join ($password.ToCharArray() | Sort-Object {Get-Random})

    return $password
}

# -------------------------------
# User Definitions
# -------------------------------
$users = @(
    @{First="John";    Last="Miller";  Department="IT"},
    @{First="Sarah";   Last="Kim";     Department="IT"},
    @{First="David";   Last="Brown";   Department="HR"},
    @{First="Emily";   Last="Lopez";   Department="HR"},
    @{First="Michael"; Last="Adams";   Department="Operations"},
    @{First="Laura";   Last="Nguyen";  Department="Operations"},
    @{First="James";   Last="Stone";   Department="Finance"},
    @{First="Amanda";  Last="Wong";    Department="Finance"},
    @{First="Robert";  Last="Fields";  Department="Executives"},
    @{First="Jessica"; Last="Turner";  Department="Executives"}
)

# -------------------------------
# Create Users
# -------------------------------
foreach ($u in $users) {

    # username format: first initial + last name (lowercase)
    $username = ($u.First.Substring(0,1) + $u.Last).ToLower()

    # generate guaranteed-complex password
    $password = New-RandomPassword

    # OU path based on Department
    $ouPath = "OU=$($u.Department),DC=corp,DC=local"

    try {
        New-ADUser `
            -Name "$($u.First) $($u.Last)" `
            -GivenName $u.First `
            -Surname $u.Last `
            -SamAccountName $username `
            -UserPrincipalName "$username@corp.local" `
            -Path $ouPath `
            -Department $u.Department `
            -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) `
            -Enabled $true

        Write-Host "Created user: $username in $ouPath | Password: $password" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to create $username : $($_.Exception.Message)" -ForegroundColor Red
    }
}
