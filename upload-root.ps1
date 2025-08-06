# Upload to Root Public HTML
param(
    [string]$FtpHost = "145.79.14.23",
    [string]$FtpUser = "u230709022"
)

Write-Host "UPLOADING TO ROOT PUBLIC_HTML" -ForegroundColor Green
Write-Host "==============================" -ForegroundColor Green

Write-Host "Please enter your FTP password:" -ForegroundColor Yellow
$SecurePassword = Read-Host -AsSecureString
$FtpPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword))

# Build project
Write-Host "Building project..." -ForegroundColor Yellow
npm run build

if ($LASTEXITCODE -ne 0) {
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
        Write-Host "  SUCCESS" -ForegroundColor Green
        $response.Close()
        return $true
    }
    catch {
        Write-Host "  FAILED: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

function CreateDirectory {
    param($DirectoryPath, $FtpServer, $Username, $Password)
    
    try {
        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$FtpServer$DirectoryPath")
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::MakeDirectory
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
        $ftpRequest.UsePassive = $true
        
        $response = $ftpRequest.GetResponse()
        $response.Close()
        Write-Host "Created directory: $DirectoryPath" -ForegroundColor Blue
        return $true
    }
    catch {
        return $false
    }
}

# Upload to root public_html
$distPath = ".\dist"
$remoteBasePath = "/domains/berkahcakrasolusindo.com/public_html"

if (Test-Path $distPath) {
    Write-Host "Uploading files directly to public_html root..." -ForegroundColor Yellow
    
    $allFiles = Get-ChildItem -Path $distPath -Recurse -File
    $totalFiles = $allFiles.Count
    $currentFile = 0
    $successCount = 0
    
    # Create directory structure first
    $allDirs = Get-ChildItem -Path $distPath -Recurse -Directory
    foreach ($dir in $allDirs) {
        $relativePath = $dir.FullName.Substring((Resolve-Path $distPath).Path.Length)
        $remoteDirPath = "$remoteBasePath$($relativePath.Replace('\', '/'))"
        CreateDirectory -DirectoryPath $remoteDirPath -FtpServer $FtpHost -Username $FtpUser -Password $FtpPass | Out-Null
    }
    
    # Upload files
    foreach ($file in $allFiles) {
        $currentFile++
        $relativePath = $file.FullName.Substring((Resolve-Path $distPath).Path.Length)
        $remotePath = "$remoteBasePath$($relativePath.Replace('\', '/'))"
        
        Write-Host "[$currentFile/$totalFiles] $($file.Name)" -ForegroundColor Cyan -NoNewline
        $result = UploadFile -LocalPath $file.FullName -RemotePath $remotePath -FtpServer $FtpHost -Username $FtpUser -Password $FtpPass
        if ($result) { $successCount++ }
    }
    
    Write-Host ""
    Write-Host "UPLOAD SUMMARY:" -ForegroundColor Yellow
    Write-Host "Total files: $totalFiles" -ForegroundColor White
    Write-Host "Successful: $successCount" -ForegroundColor Green
    Write-Host "Failed: $($totalFiles - $successCount)" -ForegroundColor Red
    
    if ($successCount -gt 0) {
        Write-Host ""
        Write-Host "WEBSITE IS LIVE!" -ForegroundColor Green
        Write-Host "Visit: https://berkahcakrasolusindo.com" -ForegroundColor White
    }
    
} else {
    Write-Host "Dist folder not found!" -ForegroundColor Red
}
