
$pp = Get-PackageParameters
if (!$pp.InstallDir) { $pp.InstallDir = Join-Path "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)" "install" }
$packageArgs = @{
	packageName   = $env:ChocolateyPackageName
	unzipLocation = $pp.InstallDir
	fileType      = 'zip'
	url           = 'https://github.com/brechtsanders/winlibs_mingw/releases/download/12.2.0-14.0.6-10.0.0-ucrt-r2/winlibs-i686-posix-dwarf-gcc-12.2.0-mingw-w64ucrt-10.0.0-r2.7z'
	url64bit      = 'https://github.com/brechtsanders/winlibs_mingw/releases/download/12.2.0-14.0.6-10.0.0-ucrt-r2/winlibs-x86_64-posix-seh-gcc-12.2.0-mingw-w64ucrt-10.0.0-r2.7z'
	checksum      = '72b919e04bba534724c384270f84faeb0058887286ea578404850ea7d378bbe8'
	checksumType  = 'sha256'
	checksum64    = '95c5dcb6fae09d8abe903832c23bf74918e716bffe95aa4be0265aab6ba0f002'
	checksumType64= 'sha256'

}

New-Item -ItemType Directory -Force -Path $pp.InstallDir | Out-Null
Install-ChocolateyZipPackage @packageArgs

$("mingw32", "mingw64") | ForEach {
  $bin = (Join-Path $pp.InstallDir (Join-Path $_ "bin"))
  Write-Output "Testing path: $bin"
  If (Test-Path $bin) {
    Install-ChocolateyPath $bin
  }
}

