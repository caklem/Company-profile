# Check public_html directory
param(
    [string]$FtpHost = "145.79.14.23",
    [string]$FtpUser = "u230709022"
)

Write-Host "Checking for public_html directory..." -ForegroundColor Green

Write-Host "Please enter your FTP password:" -ForegroundColor Yellow
$SecurePassword = Read-Host -AsSecureString
$FtpPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword))

# Check if public_html exists
Write-Host "Looking for public_html folder..." -ForegroundColor Yellow
try {
    $testRequest = [System.Net.FtpWebRequest]::Create("ftp://$FtpHost/public_html")
    $testRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
    $testRequest.Credentials = New-Object System.Net.NetworkCredential($FtpUser, $FtpPass)
    $testRequest.UsePassive = $true
    
    $testResponse = $testRequest.GetResponse()
    $reader = New-Object System.IO.StreamReader($testResponse.GetResponseStream())
    $content = $reader.ReadToEnd()
    $reader.Close()
    $testResponse.Close()
    
    Write-Host "SUCCESS: public_html directory found!" -ForegroundColor Green
    Write-Host "Contents of public_html:" -ForegroundColor White
    Write-Host $content -ForegroundColor Gray
    
} catch {
    Write-Host "public_html not found: $($_.Exception.Message)" -ForegroundColor Red
    
    # Check domains folder instead
    Write-Host "Checking domains folder..." -ForegroundColor Yellow
    try {
        $testRequest2 = [System.Net.FtpWebRequest]::Create("ftp://$FtpHost/domains")
        $testRequest2.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
        $testRequest2.Credentials = New-Object System.Net.NetworkCredential($FtpUser, $FtpPass)
        $testRequest2.UsePassive = $true
        
        $testResponse2 = $testRequest2.GetResponse()
        $reader2 = New-Object System.IO.StreamReader($testResponse2.GetResponseStream())
        $content2 = $reader2.ReadToEnd()
        $reader2.Close()
        $testResponse2.Close()
        
        Write-Host "Contents of domains folder:" -ForegroundColor White
        Write-Host $content2 -ForegroundColor Gray
        
    } catch {
        Write-Host "domains folder also not accessible: $($_.Exception.Message)" -ForegroundColor Red
    }
}
