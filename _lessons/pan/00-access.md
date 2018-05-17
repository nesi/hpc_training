---
layout: post
title: Getting access
permalink: /lessons/pan/getting-access/
chapter: pan
---

Please note that these instructions are for NeSI Pan cluster.

### Getting an account on NeSI

If you don't have an account, we will be able to create one for you but first we will ask you to provide us with some information.

1. Fill in the [Researcher's Profile form](https://www.nesi.org.nz/user/register)
2. On the NeSI website select "Apply for access" and then "Proposal development"
3. You will be asked to log in - you should be able to do so using Tuakiri.
4. Fill in the form for "Proposal development" providing as much detail as you can. If you are unsure about some parts, don't worry - we will help you. Just fill in the sections.


### Connecting via SSH

In both cases you will be accessing the cluster using `ssh` which stands for "Secure SHell" and is a program for establishing secure communication between two machines over a network.

### Generating SSH Keys

For the purpose of this workshop we will guide you through the process of logging on the supercomputers using SSH keys. Let's have a look at the [detailed guidelines for this procedure](https://wiki.auckland.ac.nz/display/CER/How+to+log+in+using+ssh+keys).

Once you generated (following the guidelines above) the SSH private/public pair key, please send the **public** key (which will be saved as a file on your disk) as an attachment to support@nesi.org.nz

If you are working on a Windows machine using MobaXTerm, your public key should be located in the file *XXX_rsa_key.pub* which should be in the following location:

```
C:\Users\your_username\Documents\MobaXterm\home\.ssh\XXX_rsa_key.pub
```

It will be the file which Windows will interpret as `Microsoft Publisher Document` (also, it should be the smaller file of the two): `XXX_rsa_key.pub`

If you are working on Linux or Mac, your public key will should be located in:

```
/home/your_username/.ssh/XXX_rsa_key.pub
```

Once you locate the file:
1. Open your email and attach the file with the **public key**.
2. In the subject of the email write "Public key for [your_username]"
3. Just in case - put in your username in the body of the email.
4. Send this email to support@nesi.org.nz


When the cluster administrators received your email with the attached public file, they will *authorise* the key and this will allow you log onto the cluster and start working in HPC environment.

**Note** Authorisation using SSH keys is a commonly used methods for many systems, not just NeSI or HPCs. For example, [GitHub uses this approach.](https://help.github.com/articles/connecting-to-github-with-ssh/)


### Actually connecting via SSH

Now, when you generated the SSH keys and sent in the public one (not the private one!) and it has been authorized by the administrator, you should be able to successfully login to the cluster:

```
​ssh -i ~/.ssh/XXX_rsa_key your_username@login.uoa.nesi.org.nz
```

As you see, we need to add a *flag* (-i) pointing out the ssh to the location of *your private key*.
