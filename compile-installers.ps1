# Install Selenium module if not already installed
if (-Not (Get-Module -ListAvailable -Name Selenium)) {
    Install-Module -Name Selenium -Scope CurrentUser -Force
}

# Import Selenium module
Import-Module Selenium

# Ensure Inno Setup is installed and ISCC is available in the PATH
$innoSetupPath = "C:\Program Files (x86)\Inno Setup 6\ISCC.exe"
if (-Not (Test-Path $innoSetupPath)) {
    Write-Host "Inno Setup is not installed or ISCC.exe is not available in the specified path."
    exit 1
}

# Path to the repo
$repoPath = "C:\Users\tommi\Documents\GitHub\installers-for-portable-apps"

# Change to the repo directory
Set-Location -Path $repoPath

# Download necessary folders from Proton Drive using Selenium
$destinationPath = "C:\Users\tommi\Downloads\ProtonDrive"
if (-Not (Test-Path $destinationPath)) {
    New-Item -Path $destinationPath -ItemType Directory
}

# Set up Selenium WebDriver
$driver = Start-SeChrome

# Navigate to Proton Drive login page
$driver.Navigate().GoToUrl("https://drive.protonmail.com/login")

# Log in to Proton Drive using environment variables
$username = [System.Environment]::GetEnvironmentVariable('PROTON_USERNAME', [System.EnvironmentVariableTarget]::User)
$password = [System.Environment]::GetEnvironmentVariable('PROTON_PASSWORD', [System.EnvironmentVariableTarget]::User)

$driver.FindElementById("username").SendKeys($username)
# Convert password to secure string for input
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$unsecurePassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword))
$driver.FindElementById("password").SendKeys($unsecurePassword)
$driver.FindElementById("login").Click()

# Wait for login to complete and handle 2FA if necessary
Start-Sleep -Seconds 30

# Navigate to the specific folder and download files
$driver.Navigate().GoToUrl("https://drive.proton.me/u/0/RvHUIerjNaK7Kl3Vrot2JXLFst7FzieGoPY8xpaKRBb6zhA06Ut4EDqNyg5iRp0LpCYxbheyXY62ArD7m0R9Bw==/folder/MH6TezKcgauvWdImcSnvAL86dk1A4un22XSpePGpYYwdQuqd4wGpgvGVdvmuhckCWy_jCDMQThA5RPVaC0pm4Q==?r=/RvHUIerjNaK7Kl3Vrot2JXLFst7FzieGoPY8xpaKRBb6zhA06Ut4EDqNyg5iRp0LpCYxbheyXY62ArD7m0R9Bw==/folder/N0-ns1m2mQJEEZ5XWd6tn0w4Ms-3ZFIPJeAgfw_KCAdwkM6onTJ-UYpT7hm7lTLf7DsRx7ehdBfj0KmK8IG5Dg==")
Start-Sleep -Seconds 10

# Assuming files are downloadable via a button or link, you will need to interact with the elements
# Example: Click on a download button (adjust the selector as needed)
$driver.FindElementByCssSelector(".download-button").Click()

# Wait for the download to complete
Start-Sleep -Seconds 60

# Close the browser
$driver.Quit()

# Check if files were downloaded successfully
if (-Not (Get-ChildItem -Path $destinationPath)) {
    Write-Host "Failed to download necessary files from Proton Drive."
    exit 1
}

# Find all .iss files in the repository
$issFiles = Get-ChildItem -Path $repoPath -Filter *.iss -Recurse

# Compile each .iss file found
foreach ($issFile in $issFiles) {
    Write-Host "Compiling $($issFile.FullName)"
    & $innoSetupPath $issFile.FullName
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to compile $($issFile.FullName)"
    } else {
        Write-Host "Successfully compiled $($issFile.FullName)"
    }
}