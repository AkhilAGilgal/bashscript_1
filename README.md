# Bash TCP Port Scanner

A simple, lightweight TCP port scanner written entirely in Bash. This script can be used to scan ports of a device by specifying its IP address or domain name. It does not require external tools like `nmap` or `netcat`.

### Features
*   **No Heavy Dependencies**: Uses a built-in Bash feature (`/dev/tcp`) for scanning.
*   **Flexible Port Input**: Scan a single port, a comma-separated list, or a hyphenated range.
*   **Color-Coded Output**: `OPEN` ports are green and `CLOSED` ports are red for easy reading.
*   **Timeout Handling**: Prevents the script from hanging on unresponsive (filtered) ports.

### Prerequisites

This script uses a built-in Bash feature to create TCP connections and does **not** require `netcat` (`nc`).

The only required utility is `timeout`, which is part of the `coreutils` package and is installed on most Linux systems by default. You can verify it's installed by running `which timeout`.

### Installation

1.  Save the script code as a file, for example, `scan.sh`.
2.  Make the script executable from your terminal:
    ```bash
    chmod +x scan.sh
    ```

### Usage

The script takes exactly two arguments: the target host and the port(s) to scan.

**Syntax:**
  ```bash
  ./scan.sh <host> <ports>
```

Example 1: Scan a single port: 
```
./scan.sh scanme.nmap.org 80
```

Output:
```
Starting scan on host: scanme.nmap.org
-----------------------------------
Port 80: OPEN
-----------------------------------
Scan complete.
```
