# Check domain public_html
param(
    [string]$FtpHost = "145.79.14.23",
    [string]$FtpUser = "u230709022"
)

Write-Host "Checking domain structure..." -ForegroundColor Green

Write-Host "Please enter your FTP password:" -ForegroundColor Yellow
$SecurePassword = Read-Host -AsSecureString
$FtpPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword))

# Check domain public_html
Write-Host "Checking berkahcakrasolusindo.com public_html..." -ForegroundColor Yellow
try {
    $testRequest = [System.Net.FtpWebRequest]::Create("ftp://$FtpHost/domains/berkahcakrasolusindo.com")
    $testRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
    $testRequest.Credentials = New-Object System.Net.NetworkCredential($FtpUser, $FtpPass)
    $testRequest.UsePassive = $true
    
    $testResponse = $testRequest.GetResponse()
    $reader = New-Object System.IO.StreamReader($testResponse.GetResponseStream())
    $content = $reader.ReadToEnd()
    $reader.Close()
    $testResponse.Close()
    
    Write-Host "Contents of berkahcakrasolusindo.com:" -ForegroundColor White
    Write-Host $content -ForegroundColor Gray
    
    # Now check public_html inside domain
    Write-Host "`nChecking public_html inside domain..." -ForegroundColor Yellow
    $testRequest2 = [System.Net.FtpWebRequest]::Create("ftp://$FtpHost/domains/berkahcakrasolusindo.com/public_html")
    $testRequest2.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
    $testRequest2.Credentials = New-Object System.Net.NetworkCredential($FtpUser, $FtpPass)
    $testRequest2.UsePassive = $true
    
    $testResponse2 = $testRequest2.GetResponse()
    $reader2 = New-Object System.IO.StreamReader($testResponse2.GetResponseStream())
    $content2 = $reader2.ReadToEnd()
    $reader2.Close()
    $testResponse2.Close()
    
    Write-Host "Contents of public_html:" -ForegroundColor White
    Write-Host $content2 -ForegroundColor Gray
    
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
