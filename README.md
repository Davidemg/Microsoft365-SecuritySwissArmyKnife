# Microsoft 365 Security Swiss Army Knife 
Welcome to the Microsoft 365 Security Scripting Guide. This repository is a comprehensive resource for administrators and users who manage Microsoft 365 and related services. It features a variety of PowerShell scripts designed to streamline and automate tasks, ranging from user authentication checks to security assessments and reporting.

<p align="center">
  <img width="480" src="https://github.com/Davidemg/Microsoft365-SecuritySwissArmyKnife/assets/46671313/8c5abe5a-8251-402d-8f48-ac3307b262a3">
</p>

## Getting Started

### Installation Instructions

   - Download the script to your machine.
   - Open PowerShell as an administrator.
   - Navigate to the script's directory.
   - Run the script (e.g., `.\Run.ps1`).
   - Follow on-screen instructions for task execution.

### General Information
1. **Execution Policy**: The script sets the `RemoteSigned` execution policy for the current user. If unable to set due to permissions, it prompts manual setting with administrative rights.
2. **Module Management**: Includes `CheckAndInstallModule` function to verify and install necessary modules (`ExchangeOnlineManagement`, `MSOnline`, `AzureAD`). Modules are imported for cmdlet access.
3. **Service Connections**: Features commands for connecting to Exchange Online, Azure AD, and Microsoft Online Services, with error handling for connection issues.
4. **User Interaction**: Designed for interactivity, requiring user input at various stages and enabling multiple tasks per session through a looped menu system.


## Script Usage
To execute the script, use the following command within the PowerShell window:
```
.\Run.ps1
``` 
Ensure that you have the necessary permissions and privileges to run the script successfully.

### Utiliwing the Script

To utilize the scripts in this repository, follow these steps:

1. **Select the Script**: Execute `Run.ps1` in PowerShell to access a menu of available tasks and scripts.
2. **Execution**: Choose and run the desired script from the menu, ensuring you have the necessary administrative permissions.
3. **Understanding Results**: Review the script's output, interpreting it based on the script's specific documentation. 


## Script Overview
The main script offers a user-friendly menu-driven interface, enabling users to easily select and execute a wide range of tasks, each handled by specific PowerShell scripts or functions. Key features include:

1. **Execution Policy Management:** Ensures the script runs under the required execution policy.
2. **Automated Authentication Checks:** Monitors and prompts for re-authentication to maintain security.
3. **MFA Management Options:** A submenu dedicated to managing multi-factor authentication settings.
4. **Extensive Task Coverage:** From auditing mailbox rules to exporting security reports, the script covers a broad spectrum of Microsoft 365 management tasks.
5. **Interactive User Interface:** User-friendly prompts and feedback enhance the ease of use.
6. **Persistent Menu Loop:** Enables execution of multiple tasks in a single session, improving efficiency.
7. This guide is intended to help you quickly find and utilize the scripts that best fit your administrative needs in managing Microsoft 365 services.

### Prerequisites
1. **PowerShell Environment:** The script must be run in a PowerShell environment. Ensure PowerShell is installed on your system.
2. **Required Permissions:** You must have administrative privileges to execute certain parts of the script, particularly for setting the execution policy and installing modules.
3. **Microsoft 365 Administrative Access:** For the script to function correctly, you need administrative access to Microsoft 365, Azure AD, Exchange Online, and other related services.

### Modules Used 
1. **ExchangeOnlineManagement:** Used for managing Exchange Online services.
2. **MSOnline:** The Microsoft Online Services Module for managing Microsoft 365 (formerly Office 365).
3. **AzureAD:** The Azure Active Directory module for managing Azure AD instances.
4. **ExchangeOnline:** This module provides cmdlets for managing Exchange Online services.

## Contributing
We welcome contributions to this repository. If you have a script or command that can benefit others in managing Microsoft services, please consider submitting a pull request. To contribute:
1. **Fork the Repository**: Create a fork of this repository.
2. **Make Your Changes**: Add or modify scripts in your fork.
3. **Submit a Pull Request**: Once you're happy with your changes, submit a pull request for review.

Guidelines for contributions, including coding standards and commit message formatting, can be found in the 'CONTRIBUTING.md' file.

## License
This repository and its contents are licensed under [Specify License Type]. This license allows for the reuse and modification of the scripts under certain conditions. Please refer to the 'LICENSE' file in the repository for detailed licensing terms.

## Contact and Support
For support or queries regarding the scripts, you can reach out via contact@cyberplate.be or [LinkedIn](https://linkedin.com/in/davide-m-guglielmi/). Additionally, for reporting issues or suggesting enhancements, please use the 'Issues' section of this GitHub repository. Your feedback and questions are valuable in improving these scripts and helping the community.

## References (GitHub repositories):
Other inspiring repos related to Microsoft 365 security scripting.
1. **[vanvfields](https://github.com/vanvfields)**: Scripts for configuring Microsoft 365.
2. **[Brute-Email.ps1](https://github.com/rvrsh3ll/Misc-Powershell-Scripts/blob/master/Brute-Email.ps1)**: PowerShell script for brute-forcing email.
3. **[o365recon](https://github.com/nyxgeek/o365recon)**: Script for information retrieval from O365 and AzureAD using valid credentials.
4. **[M365SATReports](https://github.com/mparlakyigit/M365SATReports)**: PowerShell script for Microsoft 365 Security Assessment Reports.
5. **[ScubaGear](https://github.com/cisagov/ScubaGear)**: Tool for verifying Microsoft 365 configuration against SCuBA Security Baseline.
6. **[MFASweep](https://github.com/dafthack/MFASweep)**: Script to test Microsoft services logins and MFA status.
7. **[hornerit](https://github.com/hornerit/powershell)**: Scripts for Office 365, Azure, Active Directory, and SharePoint.
8. **[DCToolbox](https://github.com/DanielChronlund/DCToolbox)**: PowerShell toolbox for Microsoft 365 security.
9. **[Office365 best practices](https://github.com/directorcia/Office365/blob/master/best-practices.txt)**: A guide on best practices for Office 365.
10. **[ORCA](https://github.com/cammurray/orca)**: The Office 365 ATP Recommended Configuration Analyzer.
11. **[O365-InvestigationTooling](https://github.com/OfficeDev/O365-InvestigationTooling)**: Facilitates testing and data acquisition from the Office 365 Management Activity API.
12. **[O365-Lockdown](https://github.com/LMGsec/O365-Lockdown)**: PowerShell script for securing an Office 365 environment and enabling audit logging.
13. **[o365creeper](https://github.com/LMGsec/o365creeper)**: Python script for email address validation against Office 365 without login attempts.
14. **[o365-attack-toolkit](https://github.com/mdsecactivebreach/o365-attack-toolkit)**: Toolkit for OAuth phishing attacks and information extraction using the Microsoft Graph API.
15. **[O365-Admin-Center](https://github.com/bwya77/O365-Admin-Center)**: GUI application for administering every aspect of Office 365.
16. **[Office 365 Security Optimisation Assessment](https://github.com/o365soa/Scripts)**: Scripts for Office 365 Security Optimization Assessment, a Microsoft Premier Support engagement.

