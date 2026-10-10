# Troubleshooting

Start with the error in the app's progress area and its linked log file. Logs are written to `logs/` beside the app. Exit codes alone do not identify every cause.

## The app does not open / Java was not found

Extract the entire download, copy `local-env.example.bat` to `local-env.bat`, and point `STAR_CCM_JAVA` to an existing Java 21 `javaw.exe`. The launcher also tries `JAVA_HOME` and then `javaw.exe` on `PATH` when this value is unset.

Keep `StarCleanupGui.jar`, `StarCleanup.java`, and `Start-StarCleanup.bat` together. Building from source requires a JDK with `javac.exe` and `jar.exe`.

## STAR-CCM+ launcher or license errors

Set `STAR_CCM_EXE` to your installed `starccm+.bat`, or use **Browse...** in the app to select it. Confirm the same installation can open a simulation normally. Licensing is handled by that STAR installation; each concurrent job needs capacity for a separate STAR session.

## Simulation file is incomplete

STAR may report that the object data file is incomplete because the original save did not finish. This occurs while loading, before the cleanup macro can run. The tool cannot repair the file.

Restore a known good `.sim` or `.sim~` copy under a different name, verify that it opens in STAR, then run cleanup on that copy. Keep the incomplete original for recovery assessment. If no valid copy is available, ask Siemens Support whether they can assess it.

## No generated mesh is present / mesh clearing is unavailable

The mesh action targets STAR-generated surface or volume meshes. Imported mesh representations are intentionally preserved. If STAR reports no generated mesh, disallows clearing, or still reports generated mesh after the operation, the macro reports failure and does not save.

If your goal is to remove solution data, choose **Clear solution**. For another STAR release, API differences may require a macro update; include the version/build in a compatibility issue.

## Backup deletion failed after a successful save

The cleaned simulation was saved, but the matching `.sim~` could not be removed. Check the reported backup path, folder permissions, and whether another process has the file open. The app reports this as a warning and retains the backup.

**Delete matching `.sim~` after successful save** also removes a matching backup that predates the current run. Disable that option before running if you want to retain it. The separate backup action permanently deletes only the backup files you tick.

## Cleanup is slow / multiple jobs fail

Loading and saving large simulations can be limited by RAM or disk throughput. Reduce **Concurrent STAR jobs** to 1, then try 2 if resources and licenses allow. The app runs independent sessions for different files; it does not speed up a single file by dividing its cleanup across CPUs.

Use **Stop after active jobs** to allow active saves to finish. Close selected simulations in other STAR sessions before starting cleanup.

## An error is still unclear

Open an [issue](https://github.com/notKimi/star-ccm-cleaner/issues/new/choose) with the app version, STAR version/build, action, and the relevant redacted log excerpt. Remove private paths, model names, license information, and server addresses. Do not upload simulation files.
