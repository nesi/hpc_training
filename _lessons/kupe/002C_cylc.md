---
layout: post
title: Running Cylc Suites
permalink: /lessons/kupe-vl/
chapter: kupe
---


*NOTE - some of the following settings may be configured centrally once the
HPC system has stabilised. For now each user must do it.* 


# Kupe - Running Cylc Suites

## Where to Run Cylc Daemons (Suite Server Programs)

Cylc daemons should only run on designated CS500 VMs with *cylc* in the name,
such as *cylc01* (for research users) and *ec-cylc01* (for operations). Job
status messages will be blocked on other nodes.

However, you do not need to log into the Cylc VMs in order to run suites and
interact with them, just configure `rose suite-run` to automatically place
suite daemons on the Cylc VMs:

```
# $HOME/.metomi/rose.conf
[rose-host-select]
default=cylc-vm
group{cylc-vm}=cylc01 cylc02 cylc03
method{cylc-vm}=random

[rose-suite-run]
hosts=cylc-vm
scan-hosts=cylc-vm
```

The cylc GUI and CLI commands will automatically connect to suites from any
node on the system. Also add the following to your Cylc global config file,
for `cylc scan`: 

```
# $HOME/.cylc/global.rc
[suite host scanning]
hosts = cylc01, cylc02, cylc03
```

Note that it may be necessary to log on to the Cylc hosts (cylc01, cylc02, ...) once to add these host names and public key fingerprints to the "known_hosts" list in your ssh configuration.

## Configuring Suite Run Directory Locations

Cylc stores all suite files under the standard root location
`$HOME/cylc-run/`. To avoid writing too much data to `$HOME` however,
`rose suite-run` should be configured to automatically symlink suite run
directories (and/or their underlying work and share directories) to other
locations, e.g.:

```
# $HOME/.metomi/rose.conf
[rose-suite-run]
root-dir=*=/nesi/nobackup/${USER}
hosts=cylc-vm
scan-hosts=cylc-vm
```

Note:
 * the `*` wildcard above matches host names. On our shared filesystem
the same location should do for all hosts.
 * the root location for suite work and share directories can be configured
   separately with `root-dir{share}=*=/foo/bar` and
   `root-dir{work}=*=/foo/bar`.
 * these locations can also be configured per-suite in `rose-suite.conf` files
   (in which case omit the `[rose-suite-run]` section heading).

## Submitting Jobs to the XC50

Because of the way that Slurm works, for the moment suites must treat the XC50
as a Cylc remote host - i.e. they must ssh to an XC50 login node and submit
jobs to Slurm there (they must *not* submit XC50 jobs to Slurm locally with
just the `--cluster=kupe` option to target the XC50 - jobs will submit OK like
this, but subsequent job poll and kill operations will fail).
