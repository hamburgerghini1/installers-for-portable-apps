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