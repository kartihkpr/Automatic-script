# =========================================
# Windows Auto Install Script
# Uses Winget
# =========================================

$LogFile = "install-log.txt"

function Write-Log {
    param ([string]$Message)
    $TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$TimeStamp - $Message" | Tee-Object -FilePath $LogFile -Append
}

Write-Log "Starting installation process"

if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Log "Winget is not installed."
    exit
}

$apps = @(
    @{Name="Google Chrome"; ID="Google.Chrome"},
    @{Name="Microsoft Edge"; ID="Microsoft.Edge"},
    @{Name="Visual Studio Code"; ID="Microsoft.VisualStudioCode"},
    @{Name="Git"; ID="Git.Git"},
    @{Name="Python"; ID="Python.Python.3.12"},
    @{Name="Docker Desktop"; ID="Docker.DockerDesktop"},
    @{Name="Zoom"; ID="Zoom.Zoom"},
    @{Name="Slack"; ID="SlackTechnologies.Slack"},
    @{Name="VLC"; ID="VideoLAN.VLC"},
    @{Name="Node.js"; ID="OpenJS.NodeJS.LTS"},
    @{Name="AnyDesk"; ID="AnyDeskSoftwareGmbH.AnyDesk"},
    @{Name="7zip"; ID="7zip.7zip"},
    @{Name="Notepad++"; ID="Notepad++.Notepad++"},
    @{Name="Microsoft Teams"; ID="Microsoft.Teams"}
)

foreach ($app in $apps) {
    Write-Log "Installing $($app.Name)..."
    winget install --id $($app.ID) -e --silent --accept-package-agreements --accept-source-agreements

    if ($LASTEXITCODE -eq 0) {
        Write-Log "$($app.Name) installed successfully"
    }
    else {
        Write-Log "Failed to install $($app.Name)"
    }
}

Write-Log "Installation completed"
