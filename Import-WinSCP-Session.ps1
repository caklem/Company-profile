# 🚀 WINSCP SESSION AUTO IMPORT SCRIPT
# Script untuk otomatis import session Hostinger ke WinSCP

Write-Host "🔧 WINSCP SESSION IMPORT STARTING..." -ForegroundColor Green

# Define paths
$winscpConfigPath = "$env:APPDATA\WinSCP 2"
$winscpIniFile = "$winscpConfigPath\WinSCP.ini"
$sessionFile = "Hostinger-Session.ini"
$backupFile = "$winscpConfigPath\WinSCP.ini.backup"

# Check if WinSCP is installed
if (!(Test-Path $winscpConfigPath)) {
    Write-Host "❌ WinSCP tidak ditemukan!" -ForegroundColor Red
    Write-Host "📥 Install WinSCP dulu dari: https://winscp.net/eng/download.php" -ForegroundColor Yellow
    exit 1
}

# Create backup
if (Test-Path $winscpIniFile) {
    Write-Host "📋 Creating backup WinSCP.ini..." -ForegroundColor Yellow
    Copy-Item $winscpIniFile $backupFile -Force
    Write-Host "✅ Backup created: $backupFile" -ForegroundColor Green
}

# Check if session file exists
if (!(Test-Path $sessionFile)) {
    Write-Host "❌ File $sessionFile tidak ditemukan!" -ForegroundColor Red
    Write-Host "📁 Pastikan file ada di folder yang sama dengan script ini" -ForegroundColor Yellow
    exit 1
}

# Stop WinSCP process if running
$winscpProcess = Get-Process -Name "WinSCP" -ErrorAction SilentlyContinue
if ($winscpProcess) {
    Write-Host "⏹️ Stopping WinSCP process..." -ForegroundColor Yellow
    $winscpProcess | Stop-Process -Force
    Start-Sleep -Seconds 2
}

# Import session
try {
    Write-Host "📤 Importing Hostinger session..." -ForegroundColor Yellow
    
    # Read session content
    $sessionContent = Get-Content $sessionFile -Raw
    
    if (Test-Path $winscpIniFile) {
        # Append to existing config
        Add-Content $winscpIniFile "`n$sessionContent"
    } else {
        # Create new config file
        $sessionContent | Out-File $winscpIniFile -Encoding UTF8
    }
    
    Write-Host "✅ Session berhasil di-import!" -ForegroundColor Green
    Write-Host "🚀 Session Name: Hostinger-BerkahCakraSolusindo" -ForegroundColor Cyan
    
} catch {
    Write-Host "❌ Error importing session: $($_.Exception.Message)" -ForegroundColor Red
    
    # Restore backup if available
    if (Test-Path $backupFile) {
        Write-Host "🔄 Restoring backup..." -ForegroundColor Yellow
        Copy-Item $backupFile $winscpIniFile -Force
    }
    exit 1
}

# Launch WinSCP
Write-Host "🔗 Launching WinSCP..." -ForegroundColor Cyan
Start-Process "winscp.exe" -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "🎉 IMPORT COMPLETED!" -ForegroundColor Green
Write-Host "📋 Next Steps:" -ForegroundColor Yellow
Write-Host "   1. Select session 'Hostinger-BerkahCakraSolusindo'" -ForegroundColor White
Write-Host "   2. Enter your FTP password" -ForegroundColor White
Write-Host "   3. Click Login" -ForegroundColor White
Write-Host "   4. Upload files from dist/ folder" -ForegroundColor White
Write-Host ""
Write-Host "🔧 Session Details:" -ForegroundColor Yellow
Write-Host "   Host: 145.79.14.23" -ForegroundColor White
Write-Host "   Port: 21" -ForegroundColor White
Write-Host "   Username: u230709022" -ForegroundColor White
Write-Host "   Protocol: FTP (Passive Mode)" -ForegroundColor White
Write-Host "   Target: /public_html" -ForegroundColor White

Read-Host "`nPress Enter to exit"
