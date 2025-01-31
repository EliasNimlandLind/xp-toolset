# This script removes all profile pictures from users.


# Get all users on the local computer
$users = Get-WmiObject -Class Win32_UserAccount

Write-Host $users

# Iterate through each user
foreach ($user in $users) {
    $username = $user.Name
    $profilePicturePath = "C:\Users\$username\AppData\Roaming\Microsoft\Windows\AccountPictures"

    # Check if the user has a profile picture folder
    if (Test-Path -Path $profilePicturePath) {
        # Get all image files in the AccountPictures folder
        $profilePictures = Get-ChildItem -Path $profilePicturePath -File

        foreach ($profilePicture in $profilePictures) {
            Remove-Item -Path $profilePicture.FullName -Force
            Write-Host "Removed profile picture for user: $username"
        }
    }
    else {
        Write-Host "No profile picture folder for user: $username"
    }
}
