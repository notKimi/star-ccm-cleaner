# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Luchen Wang
# Author: Luchen Wang (@notKimi)

param(
    [string] $JavaHome
)

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSCommandPath
$version = (Get-Content -LiteralPath (Join-Path $projectRoot 'VERSION') -Raw).Trim()
if ($version -notmatch '^\d+\.\d+\.\d+(-[a-zA-Z0-9.-]+)?$') {
    throw "Invalid package version: $version"
}

& (Join-Path $projectRoot 'build.ps1') -JavaHome $JavaHome

$packageName = "star-ccm-cleaner-v$version-windows"
$stagingRoot = Join-Path $projectRoot ('build\package-' + [guid]::NewGuid().ToString('N'))
$packageDir = Join-Path $stagingRoot $packageName
$releaseDir = Join-Path $projectRoot 'release'
New-Item -ItemType Directory -Path $packageDir, $releaseDir -Force | Out-Null

# Use an explicit allowlist so local configuration, logs, and model data stay out.
foreach ($file in @('StarCleanupGui.jar', 'StarCleanup.java', 'Start-StarCleanup.bat', 'local-env.example.bat')) {
    Copy-Item -LiteralPath (Join-Path $projectRoot "dist\$file") -Destination $packageDir
}
foreach ($file in @('LICENSE', 'README.md', 'CHANGELOG.md', 'VERSION')) {
    Copy-Item -LiteralPath (Join-Path $projectRoot $file) -Destination $packageDir
}
$docsDir = Join-Path $packageDir 'docs'
$assetsDir = Join-Path $docsDir 'assets'
New-Item -ItemType Directory -Path $assetsDir -Force | Out-Null
foreach ($file in @('troubleshooting.md', 'development.md')) {
    Copy-Item -LiteralPath (Join-Path $projectRoot "docs\$file") -Destination $docsDir
}
Copy-Item -LiteralPath (Join-Path $projectRoot 'CONTRIBUTING.md') -Destination $packageDir
foreach ($file in @('banner.svg', 'app-preview.png')) {
    Copy-Item -LiteralPath (Join-Path $projectRoot "docs\assets\$file") -Destination $assetsDir
}

$zipFile = Join-Path $releaseDir "$packageName.zip"
Compress-Archive -LiteralPath $packageDir -DestinationPath $zipFile -Force
$hash = (Get-FileHash -LiteralPath $zipFile -Algorithm SHA256).Hash.ToLowerInvariant()
"$hash  $packageName.zip" | Set-Content -LiteralPath (Join-Path $releaseDir 'SHA256SUMS.txt') -Encoding ascii
Write-Host "Packaged $zipFile"
