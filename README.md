---
layout: page
title: Summary
permalink: /summary/
---

# Introduction to HPC using NeSI

Training materials for a hands-on workshop on introduction to HPC using NeSI, including scripts for NeSI HPC training workshop. The materials are largely based on the content created by the University of Otago staff, New Zealand eScience Infrastructure staff and Centre for eResearh at the University of Auckland.

If you missed the live training session on November 3 2017, you can find a recording at [https://drive.google.com/file/d/15uzVnhihycyC77wmCP0X1XBs-rv1Ogvc/view]. Note: this is an unedited recording - you can skip the first 23 minutes.

#### Contributors:

Murray Cadzow, Matthew Healey, Gene Soudlenkov, Sung Bae, Benjamin Roberts, Bart Verleye, Jordi Blasco, Martin Feller, Peter Maxwell, Sina Masoud-Ansari, Danny Baillie, Tom Kelly, Alexander Pletzer, Chris Scott, Wolfgang Hayek, Brian Corrie, and Aleksandra Pawlik
(if you are contributing to the materials, please add your name to the list)


## Learning objectives (what you will know after this workshop):

* Learn how to log in on NeSI supercomputers and navigate your way through the environment set up on the login node.
* Know how to transfer (small to medium-sized) data files and scripts to the cluster via: scp or MobaXterm.
* Be able to connect to one of the build/compute nodes.
* Understand (roughly) the difference between *login*, *build*/*development* and *compute* nodes, and how to use them when working on NeSI (or other HPC) infrastructure.
* Know and understand the default resources allocation (disk quota, use of scratch space, etc), and be aware of possible problems when exceeding the quota, leaving files in scratch space and so on.
* Understand (roughly) what environment modules are. Be able to view currently loaded modules, list available modules and load the modules you want to use.
* Know what a job scheduler is for and how to use it (modify a SLURM script, use SLURM commands in the command line mode).
* Understand (roughly) what Message Passing Interface is for and become familiar with its basic use.
* Understand what queuing system is and become aware of the impact of submitting jobs to different types of queues.
* Be able to submit a job - based on the provided example using R scripts.
* Understand the advantages of using parallelism computational work, and deploy it in the case of embarrassingly parallel jobs (by modifying SLURM script). Possibly be able to evaluate if the problem is embarrassingly parallel.
* Be able to monitor the job state and execution.
* Know how to access the output of the job and download locally files with output data.
* Know the best practices for cleaning up their work environment on the cluster.
* Be familiar and adhere to the NeSI use policy.

(Possibly beyond the scope of the workshop due to time limitations but useful to achieve)
* Know how to get installed software that is not currently available on the cluster
* (Otago users) Know what the Otago High Capacity Storage (HCS) and high speed data transfer services are, and how to apply for access

## Resources

This training material has been developed based on a number of existing resources:

* [Pan cluster user wiki - Centre for eResearch at the University of Auckland](https://wiki.auckland.ac.nz/display/CER/Centre+for+eResearch+User+Documentation+Start)
* [NeSI Support Pages](https://support.nesi.org.nz/hc/en-gb)
* [Various sets of NeSI training materials](https://github.com/nesi/training)
* [University of Otago Pan cluster instructions](https://rawgit.com/dannybaillie/NeSI/master/OtagoPanInstructions.html)
