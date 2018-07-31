---
layout: post
title: Connecting to Māui and Mahuika
permalink: /lessons/maui-and-mahuika/connecting
chapter: maui-and-mahuika
---

## Objectives

You will learn:

* how to login to Māui and Mahuika

## Requirements

You will need a terminal program to log in to Māui or Mahuika:

- Windows: [MobaXterm](https://mobaxterm.mobatek.net/), Windows 10 bash, or [Putty](https://www.putty.org/)
- MacOS X: Terminal app, iTerm2
- Linux: Terminal app, xterm

You will need to have an [account](00-setting-up-account.md#setting-up-your-nesi-account) and [two-factor authentication](00-setting-up-account.md#setting-up-two-factor-authentication) set up.

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

To compile code, submit jobs to the scheduler and access your data, you will need to connect to one of the Māui or Mahuika login nodes.

For Mahuika:
```
ssh -Y login.mahuika.nesi.org.nz
```

For Māui:
```
ssh -Y login.maui.nesi.org.nz
```

Your password and a new second factor may be required for this step (going from the lander node to the Māui or Mahuika login nodes). We plan to change this so that a password will not be required for this step in the future.

## Jumping across the lander node

On most Linux, Windows and MacOS machines the login process can be simplified to just a single SSH command, jumping across the lander node on the way to either the Māui or Mahuika login nodes.

### Windows
If you use MobaXterm on Windows, activate the "Connect through SSH gateway (jump host)" section in the "Advanced SSH settings" tab and enter `lander02.nesi.org.nz` in the "Gateway SSH server" field, as well as your username in the "User" field.

### Linux and MacOS
On Linux and MacOS machines, with the following lines in your `~/.ssh/config` file (replacing `myusername` with your username) you can run the command `ssh mahuika` on your machine and it will take you straight to Mahuika (`ssh maui` for Māui). 

```
Host mahuika
   User myusername
   Hostname login.mahuika.nesi.org.nz
   ProxyCommand ssh -W %h:%p lander
   ForwardX11 yes
   ForwardX11Trusted yes
   ServerAliveInterval 300
   ServerAliveCountMax 2

Host maui
   User myusername
   Hostname login.maui.nesi.org.nz
   ProxyCommand ssh -W %h:%p lander
   ForwardX11 yes
   ForwardX11Trusted yes
   ServerAliveInterval 300
   ServerAliveCountMax 2

Host lander
   User myusername
   HostName lander02.nesi.org.nz
   ForwardX11 yes
   ForwardX11Trusted yes
   ServerAliveInterval 300
   ServerAliveCountMax 2
```

The `ForwardX11` directives will enable X11 forwarding and are optional. The `ServerAlive` directives will stop the connection from hanging when you don't type anything in for some time.

This can be combined with the `Control` directives to make subsequent SSH logins and SCP commands use the same connection (i.e. without needing to type a password in again). For example, to enable this for all connections add the following section to your `~/.ssh/config` file:
```
Host *
    ControlMaster auto
    ControlPath ~/.ssh/sockets/ssh_mux_%h_%p_%r
    ControlPersist 1
```
and be sure to run: `mkdir -p ~/.ssh/sockets`.
