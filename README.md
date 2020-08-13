# XBPS Virtual Environments
Convenient separated void-packages environments.

# Table Of Contents
- [Overview](#overview)
- [Examples](#examples)
- [Install](#install)

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
1. Clone down this repository
2. Make a symlink from the `xbpsvenv` file to `/usr/local/bin/xbpsvenv`
