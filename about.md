---
layout: page
title: About
permalink: /about/
---

## How to use New Zealand eScience Infrastructure

This website includes training materials for a hands-on workshop on introduction to HPC using NeSI, intermediate and advanced HPC skills.

The material is divided into different sections: <br/>
* Introduction to HPC using NeSI
* Intermediate HPC skills
* Advanced HPC skills
* Kupe cluster
* Mahuika cluster
* Māui cluster
* Pan cluster (to be decommissioned in 2018)

The Kupe Section covers:<br/>
1)    Architecture <br/>
2)    Programming environment <br/>
3)    How to access the system resources <br/>
4)    Differences between HPC3 and Dev System <br/>
5)    File systems and their usage <br/>
6)    Data transfer and access <br/>
7)    Job scheduler <br/>
8)    Where are my files – from FitzRoy (why are recent files created on FitzRoy not on Kupe) <br/>
9)    Software available <br/>
10)   Getting help and finding documentation <br/>
11)   Options for formal training later in the year (covering: Cray programming environment,  Allinea and more)


#### Contributors:

Murray Cadzow, Matthew Healey, Gene Soudlenkov, Sung Bae, Benjamin Roberts,  Bart Verleye, Jordi Blasco, Martin Feller, Peter Maxwell, Sina Masoud-Ansari, Danny Baillie, Tom Kelly, Alexander Pletzer, Chris Scott and Aleksandra Pawlik
(if you are contributing to the materials, please add your name to the list)


## The overall learning objectives for this training materials are:

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
