# Active Directory Home Lab — Setup Guide (Day 1)

## Overview

This document explains what was completed on Day 1 of setting up the Active Directory home lab. 

---

## What Was Installed

### Virtual Machine Setup

A Windows Server 2022 virtual machine was created in VirtualBox. The machine was configured with the following basic settings:

* 4 GB of RAM
* 2 CPU cores
* 60 GB of storage
* A network adapter using an Internal Network

Windows Server 2022 was installed on this VM, and the Administrator account was used for initial configuration.

### Server Roles

The following Windows Server roles were installed:

* Active Directory Domain Services (AD DS)
* DNS Server

These are the two core components needed for creating and managing a Windows-based domain.

---

## Day 1 Summary

Below is a clear outline of everything completed on the first day.

### 1. Installed Windows Server 2022

* Created the VM in VirtualBox
* Mounted the Windows Server ISO
* Completed the operating system installation
* Signed in as Administrator for the first-time setup

### 2. Configured Static Networking

* Opened the Network Connections panel
* Assigned a static IPv4 address
* Set the DNS server to the server’s own IP
* Verified that the adapter was active and properly configured

A static IP is required so the domain controller does not change addresses when rebooted.

### 3. Installed AD DS and DNS

* Opened Server Manager
* Added the AD DS and DNS roles
* Completed the role installation

### 4. Promoted the Server to a Domain Controller

* Created a new forest
* Specified a domain name
* Allowed the server to restart after domain promotion

After this step, the server became “DC1,” the first domain controller in the environment.

### 5. Took Documentation Screenshots

All required screenshots were captured and stored for uploading to GitHub.

---

## Screenshots

### Server Manager Home

![](C:/Users/jack/OneDrive/Desktop/Projects/active-directory-homelab/Day1_Screenshots/01_ServerManager_Home.png)

### AD DS Roles Installed

![](C:/Users/jack/OneDrive/Desktop/Projects/active-directory-homelab/Day1_Screenshots/02_ADDS_Roles_Installed.png)

### DNS Server Roles Installed

![](C:/Users/jack/OneDrive/Desktop/Projects/active-directory-homelab/Day1_Screenshots/03_DNS_Roles_Installed.png)

### DC1 System Information

![](C:/Users/jack/OneDrive/Desktop/Projects/active-directory-homelab/Day1_Screenshots/04_DC1_SystemInfo.png)

### Static IP Configuration

![](C:/Users/jack/OneDrive/Desktop/Projects/active-directory-homelab/Day1_Screenshots/05_StaticIP_Config.png)


