# PowerShell Deployment Script for Hostinger - Secure Version
# Deploy-Hostinger-Secure.ps1

Write-Host "🚀 Hostinger Deployment Script" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green

# FTP Configuration
$FtpHost = "145.79.14.23"
$FtpUser = "u230709022"
$RemoteDir = "/public_html"
$LocalDir = ".\dist"

# Get password securely
$SecurePassword = Read-Host "Enter FTP Password" -AsSecureString
$FtpPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword))

Write-Host "📦 Building project..." -ForegroundColor Yellow
npm run build

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Build successful!" -ForegroundColor Green
} else {
    Write-Host "❌ Build failed!" -ForegroundColor Red
    exit 1
}

# Function to upload file via FTP
function Upload-FtpFile {
    param(
        [string]$LocalPath,
        [string]$RemoteFile,
        [string]$FtpServer,
        [string]$Username,
        [string]$Password
    )
    
    try {
        $FtpRequest = [System.Net.FtpWebRequest]::Create("ftp://$FtpServer$RemoteFile")
        $FtpRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
        $FtpRequest.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
        $FtpRequest.UseBinary = $true
        $FtpRequest.UsePassive = $true
        
        $FileContent = [System.IO.File]::ReadAllBytes($LocalPath)
        $FtpRequest.ContentLength = $FileContent.Length
        
        $RequestStream = $FtpRequest.GetRequestStream()
        $RequestStream.Write($FileContent, 0, $FileContent.Length)
        $RequestStream.Close()
        
        $Response = $FtpRequest.GetResponse()
        $Response.Close()
        
        return $true
    }
    catch {
        Write-Host "❌ Error uploading $LocalPath : $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Function to create directory via FTP
function Create-FtpDirectory {
    param(
        [string]$DirectoryPath,
        [string]$FtpServer,
        [string]$Username,
        [string]$Password
    )
    
    try {
        $FtpRequest = [System.Net.FtpWebRequest]::Create("ftp://$FtpServer$DirectoryPath")
        $FtpRequest.Method = [System.Net.WebRequestMethods+Ftp]::MakeDirectory
        $FtpRequest.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
        
        $Response = $FtpRequest.GetResponse()
        $Response.Close()
        return $true
    }
    catch {
        # Directory might already exist, that's okay
        return $false
    }
}

Write-Host "📤 Starting upload to Hostinger..." -ForegroundColor Yellow
Write-Host "Server: $FtpHost" -ForegroundColor Cyan
Write-Host "User: $FtpUser" -ForegroundColor Cyan
Write-Host "Target: $RemoteDir" -ForegroundColor Cyan

if (Test-Path $LocalDir) {
    $TotalFiles = (Get-ChildItem -Path $LocalDir -Recurse -File).Count
    $CurrentFile = 0
    
    Get-ChildItem -Path $LocalDir -Recurse -File | ForEach-Object {
        $CurrentFile++
        $relativePath = $_.FullName.Substring((Resolve-Path $LocalDir).Path.Length)
        $remotePath = "$RemoteDir$($relativePath.Replace('\', '/'))"
        
        # Create directory if needed
        $remoteDirectory = Split-Path $remotePath -Parent
        if ($remoteDirectory -ne $RemoteDir) {
            Create-FtpDirectory -DirectoryPath $remoteDirectory -FtpServer $FtpHost -Username $FtpUser -Password $FtpPass | Out-Null
        }
        
        Write-Host "[$CurrentFile/$TotalFiles] Uploading: $($_.Name)" -ForegroundColor Cyan
        $success = Upload-FtpFile -LocalPath $_.FullName -RemoteFile $remotePath -FtpServer $FtpHost -Username $FtpUser -Password $FtpPass
        
        if ($success) {
            Write-Host "  ✅ Success" -ForegroundColor Green
        } else {
            Write-Host "  ❌ Failed" -ForegroundColor Red
        }
    }
    
    Write-Host ""
    Write-Host "🎉 Deployment completed!" -ForegroundColor Green
    Write-Host "🌐 Your website should be live now!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "📋 Next steps:" -ForegroundColor White
    Write-Host "1. Check your website in browser" -ForegroundColor Gray
    Write-Host "2. Setup SSL certificate in hPanel" -ForegroundColor Gray
    Write-Host "3. Test on mobile devices" -ForegroundColor Gray
    
} else {
    Write-Host "❌ Dist folder not found. Please run build first." -ForegroundColor Red
}

# Clear password from memory
$FtpPass = $null
$SecurePassword = $null
