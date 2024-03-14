$ErrorActionPreference = 'Stop'; # Stop on all errors.

# Source registry key values which are shared between install and uninstall.
. $PSScriptRoot\regKeys.ps1

New-Item "$CMakeSystemRepositoryPath\$CMakePackageName" -ItemType directory -Force
New-ItemProperty -Name "CMakePackageDir" -PropertyType String -Value "$env:ChocolateyPackageFolder\share\cmake" -Path "$CMakeSystemRepositoryPath\$CMakePackageName" -Force
