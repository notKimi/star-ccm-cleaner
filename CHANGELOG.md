# Changelog

## Unreleased

- Use **Luchen Wang (@notKimi)** in the README, source author headers, and app footer.

## 0.1.0 — 2026-10-10

First packaged public release, under the name **STAR-CCM+ Cleaner**.

- Clear STAR-generated meshes, saved solutions, or both from selected `.sim` files.
- Select files across multiple folders, with optional subfolder scanning.
- Filter by last modified age and minimum/maximum size in decimal GB.
- Invert checkbox selection and check/uncheck highlighted rows together.
- Run 1–4 concurrent STAR sessions, with a log for each job.
- Delete matching `.sim~` backups only after a confirmed successful save, or delete selected backups separately.
- Preserve imported mesh representations and reject unavailable generated-mesh cleanup before saving.
- Show STAR errors and explain incomplete simulation files caused by unfinished saves.
- Add a Windows download, app preview, troubleshooting guide, and contribution instructions.

Mesh cleanup has been verified with STAR-CCM+ 2602.0001, build 21.02.008-R8. Other STAR releases have not been verified.

Author: Luchen Wang (@notKimi). License: MIT.
