# Simple FTP Upload Script - Try Again
param(
    [string]$FtpHost = "145.79.14.23",
    [string]$User = "u230709022"
)

Write-Host "=== HOSTINGER FTP UPLOAD SCRIPT ===" -ForegroundColor Green

# Get password
$Password = Read-Host "Enter FTP Password" -AsSecureString
$PlainPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password))

# Build first
Write-Host "Building project..." -ForegroundColor Yellow
npm run build
if ($LASTEXITCODE -ne 0) { exit 1 }

# Simple upload function with better error handling
function Send-FtpFile {
    param($LocalFile, $RemoteFile)
    
    $attempts = 0
    $maxAttempts = 3
    
    while ($attempts -lt $maxAttempts) {
        try {
            $ftp = [System.Net.FtpWebRequest]::Create("ftp://$FtpHost$RemoteFile")
            $ftp.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
            $ftp.Credentials = New-Object System.Net.NetworkCredential($User, $PlainPassword)
            $ftp.UseBinary = $true
            $ftp.UsePassive = $true
            $ftp.KeepAlive = $false
            $ftp.Timeout = 30000
            
            $content = [System.IO.File]::ReadAllBytes($LocalFile)
            $ftp.ContentLength = $content.Length
            
            $stream = $ftp.GetRequestStream()
            $stream.Write($content, 0, $content.Length)
            $stream.Close()
            
            $response = $ftp.GetResponse()
            $response.Close()
            
            Write-Host "  ✓ SUCCESS" -ForegroundColor Green
            return $true
        }
        catch {
            $attempts++
            Write-Host "  ✗ Attempt $attempts failed: $($_.Exception.Message)" -ForegroundColor Red
            if ($attempts -lt $maxAttempts) {
                Write-Host "  → Retrying in 2 seconds..." -ForegroundColor Yellow
                Start-Sleep 2
            }
        }
    }
    return $false
}

# Test connection first
Write-Host "Testing connection..." -ForegroundColor Yellow
try {
    $test = [System.Net.FtpWebRequest]::Create("ftp://$FtpHost/")
    $test.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
    $test.Credentials = New-Object System.Net.NetworkCredential($User, $PlainPassword)
    $test.UsePassive = $true
    $test.Timeout = 10000
    
    $response = $test.GetResponse()
    $response.Close()
    Write-Host "✓ Connection successful!" -ForegroundColor Green
}
catch {
    Write-Host "✗ Connection failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Upload files one by one
$basePath = "/domains/berkahcakrasolusindo.com/public_html"
$localPath = ".\dist"

if (!(Test-Path $localPath)) {
    Write-Host "✗ Dist folder not found!" -ForegroundColor Red
    exit 1
}

Write-Host "Starting upload to: $basePath" -ForegroundColor Yellow

# Get all files
$files = Get-ChildItem -Path $localPath -Recurse -File
$total = $files.Count
$success = 0
$current = 0

foreach ($file in $files) {
    $current++
    $relativePath = $file.FullName.Substring((Resolve-Path $localPath).Path.Length)
    $remotePath = "$basePath$($relativePath.Replace('\', '/'))"
    
    Write-Host "[$current/$total] $($file.Name)" -ForegroundColor Cyan -NoNewline
    
    if (Send-FtpFile -LocalFile $file.FullName -RemoteFile $remotePath) {
        $success++
    }
    
    # Small delay to prevent overwhelming server
    Start-Sleep -Milliseconds 500
}

Write-Host ""
Write-Host "=== UPLOAD COMPLETE ===" -ForegroundColor Green
Write-Host "Total files: $total" -ForegroundColor White
Write-Host "Successful: $success" -ForegroundColor Green
Write-Host "Failed: $($total - $success)" -ForegroundColor Red

if ($success -gt 0) {
    Write-Host ""
    Write-Host "🎉 Website uploaded successfully!" -ForegroundColor Green
    Write-Host "Visit: https://berkahcakrasolusindo.com" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "❌ Upload failed. Try manual upload via File Manager." -ForegroundColor Red
}
