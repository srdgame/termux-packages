# Termux packages

[![Powered by JFrog Bintray](./.github/static/powered-by-bintray.png)](https://bintray.com)

[![pipeline status](https://gitlab.com/termux-mirror/termux-packages/badges/master/pipeline.svg)](https://gitlab.com/termux-mirror/termux-packages/commits/android-5)
[![Join the chat at https://gitter.im/termux/termux](https://badges.gitter.im/termux/termux.svg)](https://gitter.im/termux/termux)

This project contains scripts and patches to build packages for the [Termux](https://termux.com/) Android application. Note that packages are cross-compiled and on-device builds are not currently supported.

More information can be found in the [docs](docs/) directory.

## Directory Structure

- [disabled-packages](disabled-packages/): Packages that cannot be built or have serious issues.

- [docs](docs/): Documentation on how to build, formatting etc.

- [ndk-patches](ndk-patches/): Patches for Android NDK headers.

- [packages](packages/): All currently available packages.

- [scripts](scripts/): Utility scripts for building.

## Issues

The two most common types of issues are package requests and bug reports. There are already templates available.

You can open an issue for any package or build problems. For example, if you observing crashes or other kind of malfunction, you are certainly welcome to file an issue.

Also, if you want to request a particular package, you may suggest it in an issue. However, be prepared that package may not be available shortly. Bugfixes and improvements take precedence over new packages.

## Pull Requests

We welcome any pull requests. Nevertheless, a log file should be provided in order to show that it is at least working.

Normally, all pull requests will be tested by [Travis CI](https://travis-ci.org/termux/termux-packages). However, in case if you are banned or for whatever reason do no use Travis CI, you should provide a log file by yourself.

All tests for master branch are done by Gitlab CI.

## Contacts

- General Mailing List: https://groups.io/g/termux

- Developer Mailing List: https://groups.io/g/termux-dev

- Developer Chat: https://gitter.im/termux/dev or #termux/development on IRC/freenode.

If you are interested in our weekly development sessions, please check the https://wiki.termux.com/wiki/Dev:Development_Sessions. Also, you may want to check the https://wiki.termux.com/wiki/Development.
