# Group Policy Objects (GPO) Notes

## Overview

This document provides detailed notes and configuration information for all Group Policy Objects created in the Active Directory home lab environment.

---

## GPO #1: Password Policy

### Purpose
Enforces strong password requirements at the domain level to enhance security and prevent weak password usage.

### Configuration Path
```
Computer Configuration
  → Policies
    → Windows Settings
      → Security Settings
        → Account Policies
          → Password Policy
```

### Settings Configured

| Setting | Value | Description |
|---------|-------|-------------|
| Minimum password length | 8 characters | Requires passwords to be at least 8 characters long |
| Password must meet complexity requirements | Enabled | Requires passwords to contain uppercase, lowercase, numbers, and special characters |
| Maximum password age | 60 days | Forces users to change passwords every 60 days |
| Minimum password age | 1 day | Prevents users from immediately changing passwords again |

### Linking
- **Linked at**: Domain level (required for Account Policies)
- **Applies to**: All users in the domain

### Notes
- Account Policies (Password Policy, Account Lockout Policy) can only be applied at the domain level in Active Directory
- This policy takes precedence over local computer password policies
- Password complexity requirements help prevent dictionary attacks and brute force attempts

---

## GPO #2: Screen Lock Policy

### Purpose
Automatically locks workstations after a period of user inactivity to protect against unauthorized access.

### Configuration Path
```
Computer Configuration
  → Policies
    → Administrative Templates
      → Control Panel
        → Personalization
```

### Settings Configured

| Setting | Value | Description |
|---------|-------|-------------|
| Screen saver timeout | 600 seconds (10 minutes) | Activates screen saver after 10 minutes of inactivity |
| Password protect the screen saver | Enabled | Requires password to unlock the workstation |
| Force specific screen saver | Enabled | Forces a specific screen saver executable (scrnsave.scr) |

### Linking
- **Linked to**: IT OU, Operations OU
- **Applies to**: All computers in the IT and Operations organizational units

### Notes
- This policy helps protect workstations when users step away from their desks
- The 10-minute timeout balances security with user convenience
- Password protection ensures only authorized users can unlock the workstation

---

## GPO #3: Block USB Storage

### Purpose
Prevents unauthorized use of USB storage devices to protect against data theft and malware introduction.

### Configuration Path
```
Computer Configuration
  → Policies
    → Administrative Templates
      → System
        → Removable Storage Access
```

### Settings Configured

| Setting | Value | Description |
|---------|-------|-------------|
| Removable Disks: Deny read access | Enabled | Prevents reading from USB storage devices |
| Removable Disks: Deny write access | Enabled | Prevents writing to USB storage devices |

### Linking
- **Linked to**: IT OU
- **Applies to**: All computers in the IT organizational unit

### Notes
- This security policy helps prevent data exfiltration and unauthorized data transfer
- Blocks both read and write access to ensure complete protection
- May need exceptions for specific business requirements (can be configured via security filtering)

---

## GPO #4: Desktop Wallpaper

### Purpose
Applies a corporate wallpaper to user desktops for consistent branding and visual confirmation of Group Policy functionality.

### Configuration Path
```
User Configuration
  → Policies
    → Administrative Templates
      → Desktop
        → Desktop
```

### Settings Configured

| Setting | Value | Description |
|---------|-------|-------------|
| Desktop wallpaper | Enabled | Applies a corporate wallpaper to user desktops |
| Wallpaper path | C:\Wallpaper\corpwallpaper.jpg | Path to the wallpaper image file |
| Style | Fill | Wallpaper display style (Fill) |

### Linking
- **Linked to**: Executives OU
- **Applies to**: All users in the Executives organizational unit

### Notes
- This is a user-based policy (not computer-based)
- Provides visual confirmation that Group Policy is working correctly
- The wallpaper file must exist at the specified path on each computer
- Can be used for branding and organizational identity

---

## GPO Management Best Practices

### Order of Operations
1. Create the GPO in Group Policy Management Console
2. Edit the GPO to configure settings
3. Link the GPO to the appropriate OU or domain
4. Verify the link and inheritance
5. Force policy update with `gpupdate /force`
6. Verify application with `gpresult /r`

### Verification Commands

**Force Policy Update:**
```powershell
gpupdate /force
```

**View Applied Policies:**
```powershell
gpresult /r
```

**Generate HTML Report:**
```powershell
gpresult /h C:\gporeport.html
```

### Common Issues and Solutions

**Policies not applying:**
- Verify GPO is linked to the correct OU
- Check that the computer/user is in the correct OU
- Ensure GPO is not disabled
- Verify inheritance is not blocked
- Run `gpupdate /force` to force refresh

**Password Policy not working:**
- Ensure Password Policy is linked at the domain level (not OU level)
- Account Policies only apply at domain root
- Verify settings are configured correctly

**User-based vs Computer-based:**
- Computer Configuration policies apply to computers regardless of user
- User Configuration policies apply to users regardless of computer
- Choose the appropriate configuration based on your requirements

---

## GPO Linking Summary

| GPO Name | Linked To | Type | Applies To |
|----------|-----------|------|------------|
| Password Policy | Domain | Computer | All domain users |
| Screen Lock Policy | IT OU, Operations OU | Computer | IT and Operations computers |
| Block USB Storage | IT OU | Computer | IT computers |
| Desktop Wallpaper | Executives OU | User | Executives users |

---

## Additional Resources

- [Microsoft Group Policy Documentation](https://docs.microsoft.com/en-us/windows-server/identity/group-policy/group-policy-overview)
- [Group Policy Management Console (GPMC)](https://docs.microsoft.com/en-us/windows-server/identity/group-policy/group-policy-management-console)
- [Troubleshooting Group Policy](https://docs.microsoft.com/en-us/troubleshoot/windows-server/group-policy/troubleshoot-group-policy-application-issues)

