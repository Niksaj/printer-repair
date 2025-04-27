# Printer Repair
This is a quick and dirty script that attempts to resume a printer if it has been paused. It is intended to resolve the issue that sometimes occurs where a check-in printer enters a paused state and will not print documents.

## Usage
To use, download the repository as a .zip archive and extract. Use the `Repair.exe` shortcut to run.

You will also need to enable script execution. Run the following line in a administrator Powershell window.

> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

### Configuration

| File                | Description                       |
|-------------------- | --------------------------------- |
| printer_name.conf   | Contains the name of the printer. |
| printer_status.conf | Contains the idle status code.    |

### Transcripts

Transcripts are written to a relative directory `transcripts`.
