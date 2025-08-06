# Final Upload Script for Hostinger
param(
    [string]$FtpHost = "145.79.14.23",
    [string]$FtpUser = "u230709022"
)

Write-Host "HOSTINGER DEPLOYMENT SCRIPT" -ForegroundColor Green
Write-Host "=============================" -ForegroundColor Green

Write-Host "Please enter your FTP password:" -ForegroundColor Yellow
$SecurePassword = Read-Host -AsSecureString
$FtpPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword))

# Build project
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

function CreateDirectory {
    param($DirectoryPath, $FtpServer, $Username, $Password)
    
    try {
        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$FtpServer$DirectoryPath")
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::MakeDirectory
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
        $ftpRequest.UsePassive = $true
        
        $response = $ftpRequest.GetResponse()
        $response.Close()
        return $true
    }
    catch {
        return $false
    }
}

# Upload to correct path
$distPath = ".\dist"
$remoteBasePath = "/domains/berkahcakrasolusindo.com/public_html"

if (Test-Path $distPath) {
    Write-Host "Uploading to berkahcakrasolusindo.com..." -ForegroundColor Yellow
    
    # Create main directory if needed
    CreateDirectory -DirectoryPath "$remoteBasePath/company-profile" -FtpServer $FtpHost -Username $FtpUser -Password $FtpPass | Out-Null
    
    $allFiles = Get-ChildItem -Path $distPath -Recurse -File
    $totalFiles = $allFiles.Count
    $currentFile = 0
    
    # Create directory structure first
    $directories = Get-ChildItem -Path $distPath -Recurse -Directory
    foreach ($dir in $directories) {
        $relativePath = $dir.FullName.Substring((Resolve-Path $distPath).Path.Length)
        $remoteDirPath = "$remoteBasePath/company-profile$($relativePath.Replace('\', '/'))"
        Write-Host "Creating directory: $relativeDirPath" -ForegroundColor Blue
        CreateDirectory -DirectoryPath $remoteDirPath -FtpServer $FtpHost -Username $FtpUser -Password $FtpPass | Out-Null
    }
    
    # Upload files
    foreach ($file in $allFiles) {
        $currentFile++
        $relativePath = $file.FullName.Substring((Resolve-Path $distPath).Path.Length)
        $remotePath = "$remoteBasePath/company-profile$($relativePath.Replace('\', '/'))"
        
        Write-Host "[$currentFile/$totalFiles] Uploading: $($file.Name)" -ForegroundColor Cyan
        UploadFile -LocalPath $file.FullName -RemotePath $remotePath -FtpServer $FtpHost -Username $FtpUser -Password $FtpPass
    }
    
    Write-Host ""
    Write-Host "DEPLOYMENT COMPLETED!" -ForegroundColor Green
    Write-Host "Your website is now live at:" -ForegroundColor Yellow
    Write-Host "https://berkahcakrasolusindo.com/company-profile" -ForegroundColor White
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Visit your website to check if everything works" -ForegroundColor White
    Write-Host "2. Setup SSL certificate in hPanel if not already active" -ForegroundColor White
    Write-Host "3. Test on mobile devices" -ForegroundColor White
    
} else {
    Write-Host "Dist folder not found!" -ForegroundColor Red
}
