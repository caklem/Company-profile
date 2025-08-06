# Simple FTP Upload - Final Try
param(
    [string]$FtpHost = "145.79.14.23",
    [string]$User = "u230709022"
)

Write-Host "=== HOSTINGER UPLOAD ===" -ForegroundColor Green

$Password = Read-Host "Enter FTP Password" -AsSecureString
$PlainPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password))

Write-Host "Building project..." -ForegroundColor Yellow
npm run build
if ($LASTEXITCODE -ne 0) { 
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1 
}

function Send-File {
    param($LocalFile, $RemoteFile)
    
    try {
        $ftp = [System.Net.FtpWebRequest]::Create("ftp://$FtpHost$RemoteFile")
        $ftp.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
        $ftp.Credentials = New-Object System.Net.NetworkCredential($User, $PlainPassword)
        $ftp.UseBinary = $true
        $ftp.UsePassive = $true
        $ftp.KeepAlive = $false
        
        $content = [System.IO.File]::ReadAllBytes($LocalFile)
        $ftp.ContentLength = $content.Length
        
        $stream = $ftp.GetRequestStream()
        $stream.Write($content, 0, $content.Length)
        $stream.Close()
        
        $response = $ftp.GetResponse()
        $response.Close()
        
        Write-Host "  SUCCESS" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "  FAILED: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

Write-Host "Testing connection..." -ForegroundColor Yellow
try {
    $test = [System.Net.FtpWebRequest]::Create("ftp://$FtpHost/")
    $test.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
    $test.Credentials = New-Object System.Net.NetworkCredential($User, $PlainPassword)
    $test.UsePassive = $true
    
    $response = $test.GetResponse()
    $response.Close()
    Write-Host "Connection OK!" -ForegroundColor Green
}
catch {
    Write-Host "Connection failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

$basePath = "/domains/berkahcakrasolusindo.com/public_html"
$localPath = ".\dist"

if (!(Test-Path $localPath)) {
    Write-Host "Dist folder not found!" -ForegroundColor Red
    exit 1
}

Write-Host "Starting upload..." -ForegroundColor Yellow

$files = Get-ChildItem -Path $localPath -Recurse -File
$total = $files.Count
$success = 0
$current = 0

foreach ($file in $files) {
    $current++
    $relativePath = $file.FullName.Substring((Resolve-Path $localPath).Path.Length)
    $remotePath = $basePath + $relativePath.Replace('\', '/')
    
    Write-Host "[$current/$total] $($file.Name)" -ForegroundColor Cyan -NoNewline
    
    if (Send-File -LocalFile $file.FullName -RemoteFile $remotePath) {
        $success++
    }
    
    Start-Sleep -Milliseconds 200
}

Write-Host ""
Write-Host "=== RESULTS ===" -ForegroundColor Green
Write-Host "Total: $total | Success: $success | Failed: $($total - $success)" -ForegroundColor White

if ($success -gt 0) {
    Write-Host "Website uploaded! Visit: https://berkahcakrasolusindo.com" -ForegroundColor Yellow
}
