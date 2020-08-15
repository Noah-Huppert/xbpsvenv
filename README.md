# XBPS Virtual Environments
Convenient separated void-packages environments.

# Table Of Contents
- [Overview](#overview)
- [Examples](#examples)
- [Install](#install)
- [Operations](#operations)

# Overview
Creates virtual xbps-src void-packages environments named **workspaces**. 
Provides programs for managing **workspaces** and performing common tasks
(ex., checking out & build changes from a PR).

Allows for multiple versions of the void-packages repository to be used at once.

Provides the `xbpsvenv` script with the commands:

- **workon**: Create a new workspace by checking out a variation of the source code
- **alias**: Set an alias for a workspace
- **exec**: Execute program in a workspace
- **ls**: List workspaces
- **note**: Set note for workspace
- **pwd**: Get location of workspace
- **rm**: Remove a workspace
- **usectx**: Set a workspace to be used by default in the future

See the [install](#install) section for installation instructions.

Have feedback or find a bug? Please open an issue, I'd love to talk with you!

# Examples
Checkout changes from GitHub Pull Request #18693 and package `curl`:

```shell
% xbpsvenv workon -p 18693
% xbpsvenv exec pkg curl
```

Clone a custom Void Packages repository, checkout the curl-dev branch, and apply
changes from the GitHub Pull Request #18693:

```shell
% xbpsvenv workon -r 'git@github.com:Noah-Huppert/void-packages.git' -c curl-dev -p 18693
```

# Install
1. Download the [latest release](https://github.com/Noah-Huppert/xbpsvenv/releases)
2. Make a symlink from the `xbpsvenv` file to `/usr/local/bin/xbpsvenv`

# Operations
## Make A Release
1. Create a new release
   1. Tag `master` `v<major>.<minor>.<patch>`.
   2. Name the release `v<major>.<minor>.<patch>`.
   3. Add a description with the following information:
      ```
	  Short one sentence summary of release.
	  
	  # Change log
	  - List of changes.
	  - At a semi-major level.
	  
	  # Files
	  | File                 | SHA256 |
	  | -------------------- | ------ |
	  | `<major>.<minor>.<patch>.tar.gz` | `badbadbadbadbadbadbadbadbadbadbadbadbadbadbadbadbadbadbadbadbadb` |
	  ```
2. Update the `xbpsvenv` Void package
   1. Edit the `srcpkgs/xbpsvenv/template` in the 
	  [void-linux/void-packages repository](https://github.com/void-linux/void-packages].
   2. Update the `version` variable.
   3. Update the `checksum` variable.
