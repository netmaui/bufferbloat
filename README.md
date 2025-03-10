# Bufferbloat Network Configuration Scripts

## Overview

This repository contains a set of batch scripts designed to configure network settings on a Windows machine to mitigate bufferbloat. Bufferbloat is a phenomenon where excessive buffering in network equipment causes high latency and jitter. These scripts help optimize network performance by adjusting various TCP/IP and network adapter settings.

## Scripts

### `Setup-All-and-Backup.bat`

This script performs the following tasks:
1. Calls the `backup-network-settings.bat` script to back up the current network settings.
2. Configures various network settings to optimize performance and reduce bufferbloat.

#### Key Actions:
- Sets DNS, Local, Hosts, and NetBT priority in the registry.
- Configures Network Throttling Index and System Responsiveness.
- Adjusts MaxUserPort, TcpTimedWaitDelay, and DefaultTTL.
- Executes PowerShell commands to configure TCP settings, offload settings, and network adapter properties.
- Uses `netsh` commands to set MTU for all active network interfaces and configure TCP congestion provider.

### `backup-network-settings.bat`

This script backs up the current network settings to a file specified by the user. It captures the following settings:
- Registry settings related to TCP/IP service provider priorities, network throttling, and TCP parameters.
- PowerShell settings for TCP, offload, and network adapter properties.

#### Key Actions:
- Prompts the user to enter the name of the backup file.
- Queries and saves the current registry settings.
- Executes PowerShell commands to capture the current TCP and network adapter settings.

### `revert-and-restore-from-backup.bat`

This script restores the network settings from a backup file specified by the user. It reads the backup file and applies the saved settings to the system.

#### Key Actions:
- Prompts the user to enter the name of the backup file to restore.
- Checks if the backup file exists.
- Restores registry settings from the backup file.
- Executes PowerShell commands to restore TCP and network adapter settings from the backup file.
- Uses `netsh` commands to configure TCP settings.

## Usage

1. **Backup Current Settings:**
   Run `backup-network-settings.bat` to create a backup of the current network settings. You will be prompted to enter the name of the backup file.

2. **Configure Network Settings:**
   Run `Setup-All-and-Backup.bat` to back up the current settings and apply the new network configuration. This script will call `backup-network-settings.bat` as part of its process.

3. **Restore Settings:**
   If you need to revert to the previous network settings, run `revert-and-restore-from-backup.bat` and provide the name of the backup file created earlier.

## Notes

- Ensure you run these scripts with administrative privileges to allow changes to system settings.
- Review the scripts and adjust the settings as needed to fit your specific network environment and requirements.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
