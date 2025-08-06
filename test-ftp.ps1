# FTP Connection Test Script
param(
    [string]$FtpHost = "145.79.14.23",
    [string]$FtpUser = "u230709022"
)

Write-Host "=== FTP Connection Test ===" -ForegroundColor Green

Write-Host "Please enter your FTP password:" -ForegroundColor Yellow
$SecurePassword = Read-Host -AsSecureString
$FtpPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword))

Write-Host "Testing connection with:" -ForegroundColor Cyan
Write-Host "Host: $FtpHost" -ForegroundColor White
Write-Host "User: $FtpUser" -ForegroundColor White
Write-Host "Password: $('*' * $FtpPass.Length)" -ForegroundColor White

# Test 1: Basic connection
Write-Host "`nTest 1: Basic FTP connection..." -ForegroundColor Yellow
try {
    $testRequest = [System.Net.FtpWebRequest]::Create("ftp://$FtpHost/")
    $testRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
    $testRequest.Credentials = New-Object System.Net.NetworkCredential($FtpUser, $FtpPass)
    $testRequest.UsePassive = $true
    $testRequest.Timeout = 10000
    
    $testResponse = $testRequest.GetResponse()
    $reader = New-Object System.IO.StreamReader($testResponse.GetResponseStream())
    $content = $reader.ReadToEnd()
    $reader.Close()
    $testResponse.Close()
    
    Write-Host "SUCCESS: Connected to FTP server!" -ForegroundColor Green
    Write-Host "Directory listing:" -ForegroundColor White
    Write-Host $content -ForegroundColor Gray
    
} catch {
    Write-Host "FAILED: $($_.Exception.Message)" -ForegroundColor Red
    
    # Suggest alternative username formats
    Write-Host "`nTrying alternative username formats..." -ForegroundColor Yellow
    
    # Test with full email format if domain is known
    $domain = "your-domain.com"  # Replace with actual domain
    $altUser = "$FtpUser@$domain"
    
    Write-Host "Test 2: Trying with domain format: $altUser" -ForegroundColor Yellow
    try {
        $testRequest2 = [System.Net.FtpWebRequest]::Create("ftp://$FtpHost/")
        $testRequest2.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
        $testRequest2.Credentials = New-Object System.Net.NetworkCredential($altUser, $FtpPass)
        $testRequest2.UsePassive = $true
        $testRequest2.Timeout = 10000
        
        $testResponse2 = $testRequest2.GetResponse()
        $testResponse2.Close()
        
        Write-Host "SUCCESS with domain format!" -ForegroundColor Green
        $FtpUser = $altUser
        
    } catch {
        Write-Host "FAILED with domain format: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n=== Troubleshooting Tips ===" -ForegroundColor Yellow
Write-Host "1. Check your hPanel -> File Manager for correct credentials" -ForegroundColor White
Write-Host "2. Make sure FTP is enabled in your hosting plan" -ForegroundColor White
Write-Host "3. Try using your main domain username if different" -ForegroundColor White
Write-Host "4. Check if your IP is blocked (some hosts restrict FTP access)" -ForegroundColor White
Write-Host "5. Try SFTP instead of FTP (port 22)" -ForegroundColor White
