---
layout: post
title: Connecting to Māui and Mahuika
permalink: /lessons/maui-and-mahuika/connecting
chapter: maui-and-mahuika
---

## Objectives

You will learn:

* how to log in to Māui and Mahuika
* how to configure your machine to connect directly to the login node
* how to minimise the number of times you have to enter your password

## Requirements

You will need a terminal program to log in to Māui or Mahuika:

- Windows: [MobaXterm](https://mobaxterm.mobatek.net/), Windows 10 bash, or [Putty](https://www.putty.org/)
- MacOS X: Terminal app, iTerm2
- Linux: Terminal app, xterm

You will need to have an [account](https://support.nesi.org.nz/hc/en-gb/articles/360000159715) and [two-factor authentication](https://support.nesi.org.nz/hc/en-gb/articles/360000203075) set up.

## Connecting to Māui and Mahuika

Connecting to Māui or Mahuika is a two step process. First, connect to NeSI's lander node by typing:
```
ssh -Y <myusername>@lander02.nesi.org.nz
```
inside your terminal program, where `<myusername>` is your account user name. You will see the following prompt:
```
First Factor:
```
Enter your password, after which you will see:
```
Second Factor (optional):
```
Enter the 6-digit code from the mobile device.

To compile code, submit jobs to the scheduler and access your data, you will need to connect to a Māui or Mahuika login node, see intructions below.

### From lander node to Mahuika login node

```
ssh -Y login.mahuika.nesi.org.nz
```
You will be prompted again to enter your password 
```
First Factor:
```
and 
```
Second Factor (optional):
```
Type `<return>` for the second factor.

### From lander node to Māui login node

```
ssh -Y login.maui.nesi.org.nz
```
You will be prompted again to enter your password:
```
Password: 
```
Type your password followed by the second factor, 6-digit code from the mobile device (e.g. `mypassword123456`).


## Jumping across the lander node

On most Linux, Windows and MacOS machines the login process can be simplified to just a single `ssh` command, jumping across the lander node on the way to either a Māui or Mahuika login node.

### Windows
If you use MobaXterm on Windows, activate the "Connect through SSH gateway (jump host)" section in the "Network settings" tab and enter `lander02.nesi.org.nz` in the "Gateway SSH server" field, as well as your username in the "User" field. (In an older version of MobaXterm the section was called "Advanced SSH settings".)

### Linux and MacOS users
Run 
```
mkdir -p ~/.ssh/sockets
```
and add the following lines to `~/.ssh/config` on your machine (replacing `<myusername>` with your username),
```
Host *
    ControlMaster auto
    ControlPath ~/.ssh/sockets/ssh_mux_%h_%p_%r
    ControlPersist 1

Host mahuika
   User <myusername>
   Hostname login.mahuika.nesi.org.nz
   ProxyCommand ssh -W %h:%p lander
   ForwardX11 yes
   ForwardX11Trusted yes
   ServerAliveInterval 300
   ServerAliveCountMax 2

Host maui
   User <myusername>
   Hostname login.maui.nesi.org.nz
   ProxyCommand ssh -W %h:%p lander
   ForwardX11 yes
   ForwardX11Trusted yes
   ServerAliveInterval 300
   ServerAliveCountMax 2

Host lander
   User <myusername>
   HostName lander02.nesi.org.nz
   ForwardX11 yes
   ForwardX11Trusted yes
   ServerAliveInterval 300
   ServerAliveCountMax 2
```

**Note:** after creating the file ~/.ssh/config you should make sure the permissions are correct: `chmod 600 ~/.ssh/config`.

This will allow you to run the command `ssh mahuika` (`ssh maui`) and bring you straight to Mahuika (Māui). With the `Control` directives, you will no longer have to type again your password with subsequent `ssh` or `scp` commands (recommended for [data transfer](https://support.nesi.org.nz/hc/en-gb/articles/360000207355)). The `ForwardX11` directives will enable X11 forwarding. The `ServerAlive` directives will stop the connection from hanging when you don't type anything for some time.
