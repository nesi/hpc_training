---
layout: post
title: Kupe - getting access
---

You will learn how to set up your account on Kupe and how to log in onto the machine. 

### Setting up account on Kupe

If you are logging in for the first time to Kupe, you will need to set up your account. First, you will need to log in to NeSI user portal. This populates NeSI database with your basic account information which will be used to set up your account.

1. Access [My NeSI  Portal](https://my.nesi.org.nz) via your browser.
2. Log in using your institutional credentials via Tuakiri. See example below for logging in with NIWA credentials.
3. After successful login, you should see a screen similar to the one below.
4. Please click on ‘Reset Password’ button to proceed. It will send you an e-mail with temporary URL.

**Note** If you don’t see ‘Reset Password’ button and instead see error messages, it means your information on our database did not match your Tuakiri identity. Please see the bottom of the page for troubleshooting section and contact Aaron and Jun at aaron.hicks@nesi.org.nz and jun.huh@nesi.org.nz, and provide us with your name and e-mail address and we will fix your account.

5. Clicking on the link on your e-mail will open up the following page that shows your temp password.


Connecting to the HPC requires two-factor authentication at all times, your password, and an additional factor. These additional factors can be:
- A keycode provided by an external generator (e.g., via smartphone app)
- Connecting from NIWA's physical network (at a NIWA branch)
- Connecting through a NIWA VPN session

### Logging in to Kupe (HPC3)

You will need a terminal program to log into Kupe:

- Windows: MobaXterm, Windows 10 bash, Putty
- MacOS X: Terminal app, iTerm2
- Linux: Terminal app

Using a terminal program and SSH into lander.nesi.org.nz using the Kupe linux username displayed on the portal and the temporary password above. (Any Kupe node can be used with ssh for the password reset, but only the lander node is accessible to external users.)

When you log in using your temporary password, the lander node will ask you to change your password immediately. Please follow the instruction on the shell.

Important: Continue from here only if you are outside NIWA. If you are connecting from inside the NIWA network or have NIWA VPN, your account is all ready to go. You can connect directly to the login node at login.kupe.niwa.co.nz.

#### Logging in from outside of NIWA computer network

Note: You can skip this section if you log on from inside the NIWA network.

Go back to My NeSI portal and click on Accounts or refresh the page and you will see a new option to ‘Link your mobile device’
Clicking on link your mobile device will prepare your 2nd factor login so that you can log in to our lander node from outside of the NIWA network.

Step 6) After clicking on ‘Link your mobile device’ you will be instructed to prepare your mobile device before proceeding.


1. Open the terminal program on your local machine and connect using `ssh`:
```
   ​ssh -X your_username@lander.nesi.org.nz
```
If you use MobaXterm or Putty, start a new ssh session with remote host `lander.nesi.org.nz` and username `your_username`, and activate "X11 forwarding".

2. Enter your password (the one you set up in NeSI User Portal) and the additional keycode.

You should now see the reply from Kupe's lander node.

#### Shells

Your login shell is ```bash```. Other shells (```ksh```, ```tcsh``` and ```csh```) are also installed and can be invoked.

#### Logging in to the login node

1. Connect using `ssh` either from your session on the lander node, or from a terminal program on your local machine if you are inside the NIWA network:
```
   ​ssh -X your_username@login.kupe.niwa.co.nz
```
2. Enter your password (the one you set up in NeSI User Portal) if required

You should now see the reply from Kupe's `elogin` node.

Proceed to the temporary `cd /nesi/transit` directory before changing or running anything on Kupe:
```
cd /nesi/transit/your_username
```

**Please do not create or modify any files or directories in your home directory or in any of the directories that were migrated from FitzRoy - synchronisation between FitzRoy and Kupe is still ongoing, and modified files on Kupe will be overwritten!**
