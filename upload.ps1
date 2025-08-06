# PowerShell Deployment Script for Hostinger
param(
    [string]$FtpHost = "145.79.14.23",
    [string]$FtpUser = "u230709022",
    [string]$FtpPass = ""
)

Write-Host "Starting deployment to Hostinger..." -ForegroundColor Green

if ([string]::IsNullOrEmpty($FtpPass)) {
    Write-Host "Please enter your FTP password:" -ForegroundColor Yellow
    $SecurePassword = Read-Host -AsSecureString
    $FtpPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword))
}

Write-Host "Building project..." -ForegroundColor Yellow
npm run build

if ($LASTEXITCODE -eq 0) {
    Write-Host "Build successful!" -ForegroundColor Green
} else {
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}

function UploadFile {
    param($LocalPath, $RemotePath, $FtpServer, $Username, $Password)
    
    try {
        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$FtpServer$RemotePath")
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
        $ftpRequest.UseBinary = $true
        $ftpRequest.UsePassive = $true
        
        $fileContent = [System.IO.File]::ReadAllBytes($LocalPath)
        $ftpRequest.ContentLength = $fileContent.Length
        
        $requestStream = $ftpRequest.GetRequestStream()
        $requestStream.Write($fileContent, 0, $fileContent.Length)
        $requestStream.Close()
        
        $response = $ftpRequest.GetResponse()
        Write-Host "  Success" -ForegroundColor Green
        $response.Close()
        return $true
    }
    catch {
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

Write-Host "Uploading to Hostinger..." -ForegroundColor Yellow

$distPath = ".\dist"

if (Test-Path $distPath) {
    Write-Host "Testing FTP connection..." -ForegroundColor Yellow
    try {
        $testRequest = [System.Net.FtpWebRequest]::Create("ftp://$FtpHost/public_html")
        $testRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
        $testRequest.Credentials = New-Object System.Net.NetworkCredential($FtpUser, $FtpPass)
        $testRequest.UsePassive = $true
        $testResponse = $testRequest.GetResponse()
        $testResponse.Close()
        Write-Host "FTP connection successful!" -ForegroundColor Green
    }
    catch {
        Write-Host "FTP connection failed: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
    
    $allFiles = Get-ChildItem -Path $distPath -Recurse -File
    $totalFiles = $allFiles.Count
    $currentFile = 0
    
    foreach ($file in $allFiles) {
        $currentFile++
        $relativePath = $file.FullName.Substring((Resolve-Path $distPath).Path.Length)
        $remotePath = "/public_html$($relativePath.Replace('\', '/'))"
        
        Write-Host "[$currentFile/$totalFiles] Uploading: $($file.Name)" -ForegroundColor Cyan
        UploadFile -LocalPath $file.FullName -RemotePath $remotePath -FtpServer $FtpHost -Username $FtpUser -Password $FtpPass
    }
    
    Write-Host ""
    Write-Host "Deployment completed!" -ForegroundColor Green
    Write-Host "Website should be live at your domain!" -ForegroundColor Yellow
    
} else {
    Write-Host "Dist folder not found. Please run build first." -ForegroundColor Red
}
