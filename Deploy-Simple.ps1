# PowerShell Deployment Script for Hostinger - Clean Version
# Deploy-Simple.ps1

Write-Host "🚀 Hostinger Deployment Script" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green

# FTP Configuration
$FtpHost = "145.79.14.23"
$FtpUser = "u230709022"
$RemoteDir = "/public_html"
$LocalDir = ".\dist"

# Get password securely
Write-Host "Please enter your FTP password:" -ForegroundColor Yellow
$SecurePassword = Read-Host -AsSecureString
$FtpPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword))

Write-Host "📦 Building project..." -ForegroundColor Yellow
npm run build

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Build successful!" -ForegroundColor Green
} else {
    Write-Host "❌ Build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "📤 Starting upload to Hostinger..." -ForegroundColor Yellow

if (Test-Path $LocalDir) {
    # Get all files to upload
    $files = Get-ChildItem -Path $LocalDir -Recurse -File
    $totalFiles = $files.Count
    $currentFile = 0
    
    foreach ($file in $files) {
        $currentFile++
        $relativePath = $file.FullName.Substring((Resolve-Path $LocalDir).Path.Length)
        $remotePath = "$RemoteDir$($relativePath.Replace('\', '/'))"
        
        Write-Host "[$currentFile/$totalFiles] Uploading: $($file.Name)" -ForegroundColor Cyan
        
        try {
            # Create FTP request
            $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$FtpHost$remotePath")
            $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
            $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($FtpUser, $FtpPass)
            $ftpRequest.UseBinary = $true
            $ftpRequest.UsePassive = $true
            
            # Read file content
            $fileContent = [System.IO.File]::ReadAllBytes($file.FullName)
            $ftpRequest.ContentLength = $fileContent.Length
            
            # Upload file
            $requestStream = $ftpRequest.GetRequestStream()
            $requestStream.Write($fileContent, 0, $fileContent.Length)
            $requestStream.Close()
            
            $response = $ftpRequest.GetResponse()
            $response.Close()
            
            Write-Host "  ✅ Success" -ForegroundColor Green
        }
        catch {
            Write-Host "  ❌ Failed: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
    
    Write-Host ""
    Write-Host "🎉 Deployment completed!" -ForegroundColor Green
    Write-Host "🌐 Your website should be live now!" -ForegroundColor Yellow
    
} else {
    Write-Host "❌ Dist folder not found!" -ForegroundColor Red
}

# Clear password
$FtpPass = $null
