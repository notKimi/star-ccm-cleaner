# Contributing to STAR-CCM+ Cleaner

Documentation improvements, compatibility reports, and focused code changes are welcome.

## Report a problem

Use the [issue templates](https://github.com/notKimi/star-ccm-cleaner/issues/new/choose). Include your app version, Windows/Java versions, STAR-CCM+ release and build, the chosen action, and how to reproduce the problem.

Share only the relevant redacted log lines. Remove confidential model names, paths, license details, and server addresses. Do not attach proprietary `.sim` or `.sim~` files.

## Report compatibility

If you try another STAR release, test on a copy and report the exact version/build, cleanup action, and outcome. For mesh cleanup, check whether imported meshes are present and whether they remain after cleanup. A successful app build alone does not verify STAR macro compatibility.

## Make a change

1. Fork the repository and make a branch for your change.
2. Follow the [development guide](docs/development.md) to build and run the existing tests.
3. Keep the change focused and preserve the source attribution.
4. Open a pull request explaining the user problem, resulting behavior, and relevant checks.

The existing tests exercise backup deletion and failure reporting with temporary files and a fake STAR process. Changes to the STAR macro need verification on copies of real simulations with a licensed installation; describe those checks in the pull request.

Contributions are distributed under the project's [MIT License](LICENSE).
