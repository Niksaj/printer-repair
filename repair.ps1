# Function to resume printing
function Resume-Print {
    Param (
        [Parameter(Position=0)]
        [string] $Name,
        [Parameter(Position=1)]
        [int] $Status = 0
    )

    $filter = ("name='{0}'" -f $name)
    $printer = gwmi win32_printer -filter $filter

    if($printer -ne $null) {
        echo "Attempting to resume printing..."
        $printer.resume()
        if ($printer.PrinterStatus -eq $status) {
            echo "Deteccting that printer is idle, printing should resume shortly."
        } else {
            echo "Printer does not appear to be idle after resuming, if printing does not resume then there may be a different issue that this script will not resolve."
        }
    }
    else {
        Write-Error ("Error: printer with name '{0}' could not be found." -f $name) 
        echo "`nThis could mean the printer is not connected, or the name is not configured correctly.`nCheck for the printer in settings and/or update name in 'printer_name.conf' if necessary."
    }
}

echo ""
echo "---------------------------------------------"
echo ""
echo "       Starting printer repair script"
echo ""
echo "---------------------------------------------"
echo ""

try {
    echo "Starting transcript"
    md -Force -Path ".\transcripts"
    Start-Transcript -Path (".\transcripts\{0}.log" -f (get-date -f "yyyy-MM-dd HHmmss"))

    echo "Reading script arguments..."

    [int] $status = Get-Content -Path "printer_status.conf" -ErrorVariable status_error -ErrorAction SilentlyContinue
    [string] $name = Get-Content -Path "printer_name.conf" -ErrorVariable name_error -ErrorAction SilentlyContinue

    if ($status_error) {
        echo "'printer_status.conf' file could not be read, using default value."
        $status = 0
    }
    if ($name_error) {
        echo "'printer_name.conf' file could not be read, using default value."
        $name = "Brother QL-800"
    }

    echo ("Using arguments (printer_name={0}, printer_status={1})" -f $name, $status)

    Resume-Print $name $status
} finally {
    Stop-Transcript
    Read-Host -Prompt "Process complete, this window can now be closed..."
}