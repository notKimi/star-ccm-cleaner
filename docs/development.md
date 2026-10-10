# Development and packaging

STAR-CCM+ Cleaner uses Java Swing for the file selection window, a small Java macro for STAR cleanup, and Windows launch/build scripts. The GUI has no third-party Java dependencies.

## Project layout

| Path | Purpose |
| --- | --- |
| `src/StarCleanupGui.java` | Window, file filters, job queue, backup deletion, and error reporting |
| `macro/StarCleanup.java` | Macro compiled and executed by STAR-CCM+ |
| `Start-StarCleanup.bat` | Windows app launcher |
| `local-env.example.bat` | Example installation paths; copy to ignored `local-env.bat` locally |
| `build.ps1` | Compile the GUI for Java 21 and create `dist/` |
| `package.ps1` | Build a public ZIP using an explicit list of files |
| `VERSION` | Version used to name the packaged download |
| `tests/BackupCleanupSmoke.java` | Backup and failure tests with a fake STAR process |
| `.github/workflows/windows.yml` | Windows build, existing smoke test, and ZIP artifact |

## Build

Run from the repository root in PowerShell with JDK 21:

```powershell
$jdk = 'C:\Path\To\JDK'
.\build.ps1 -JavaHome $jdk
```

Use JDK 21 to produce a GUI that runs on Java 21. The STAR macro is shipped as source and compiled by STAR when the app runs it. No Siemens library is needed to build the GUI.

## Run the existing smoke test

After building, run from the repository root:

```powershell
New-Item -ItemType Directory -Force -Path build\smoke, build\test-fixtures | Out-Null
& "$jdk\bin\javac.exe" -encoding UTF-8 -cp dist\StarCleanupGui.jar -d build\smoke tests\BackupCleanupSmoke.java
$guiJar = Join-Path $PWD 'dist\StarCleanupGui.jar'
$smokeClasses = Join-Path $PWD 'build\smoke'
& "$jdk\bin\java.exe" -cp "$guiJar;$smokeClasses" BackupCleanupSmoke (Join-Path $PWD 'build\test-fixtures')
```

Expected result: `BACKUP_CLEANUP_SMOKE_OK`. The test checks matching versus unrelated backups, the keep-backup option, process failures, incomplete simulation errors, missing/empty saved files, and backup deletion warnings. It uses a fake batch process and temporary text fixtures, not real simulations. Swing requires an available Windows desktop environment.

STAR API changes require separate checks with a licensed installation and copies of real `.sim` files. The current verified release is 2602.0001, build 21.02.008-R8.

## Create the Windows ZIP

```powershell
.\package.ps1 -JavaHome $jdk
```

The script reads `VERSION`, builds the GUI, and creates `release/star-ccm-cleaner-v<version>-windows.zip` plus `release/SHA256SUMS.txt`. It includes only the app, macro, launcher, example configuration, license, version, changelog, and user documentation.

Local configuration, STAR logs, simulation files, Java runtimes, Siemens binaries, tests, and `.git` metadata are excluded. `build/`, `dist/`, and `release/` are ignored by Git.

For a release, review the changelog, run the tests, inspect the ZIP contents, and publish the ZIP and checksum with a tag matching `VERSION`.
