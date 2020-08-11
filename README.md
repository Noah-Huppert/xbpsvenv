# XBPS Virtual Environments
Convenient separated void-packages environments.

# Table Of Contents
- [Overview](#overview)

# Overview
Meant to automate several common tasks (Like checking out & build changes from 
a PR). Allows for multiple versions of the void-packages repository to be used 
at once.

Example usage:

```shell
% ./workon -c master -p 2566
% ./pkg pr-2566 curl
% ./install pr-2566 curl
% ./rm pr-2566
```

The `workon` command makes a separate copy of void-packages. Passing the 
`-p 2566` option causes changes from GitHub pull request 2566 to be applied. 
Since a pull request number was provided  the `workon` script automatically 
makes an alias (i.e., nickname) for this copy of void-packages named `pr-2566`.
This only happens automatically with pull requests, use the `-a <ALIAS>` option
to override or pass manually.

The `pkg` command runs `xbps-src pkg` for the `curl` package in the `pr-2566`
void-packages copy. The `install` command installs the built `curl` package.

The `rm` command removes this copy of void-packages.
