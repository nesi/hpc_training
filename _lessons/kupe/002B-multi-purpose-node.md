---
layout: post
title: Multi-Purpose node Slurm Cluster Resources
permalink: /lessons/kupe-multi-node/
chapter: kupe
---

## Kupe Multi-Purpose node Slurm Cluster Resources

Kupe provides pre- and post-processing services, as well as &quot;general purpose&quot; serial code compute services via Slurm clusters. These are provided from both physical and virtual machines executing on the CS500 nodes, each of which is a 40 core, 2.4GHz Skylake processor, with 768GB of memory, a native Spectrum Scale (GPFS) client, and EDR (Infiniband) connectivity to storage.

Jobs are submitted to these resources via Slurm.

| Kupe Multi-Purpose Nodes | Number of Cores | Memory (GB) | Slurm Cluster | Purpose |
| --- | ---| --- | --- | --- |
| asg006.kupe.niwa.co.nz | 40 | 768 | ec\_cs | EcoConnect Forecasting operations, serial science models, pre- and post-processing, visualisation. asg006 includes a Tesla P100 GPGPU.|
| asn007.kupe.niwa.co.nz | 40 | 768 |  ec\_cs | as above|
| asn009.kupe.niwa.co.nz | 40 | 768 |  ec\_cs |as above |
|   |   |   |   |   |
| ec-sat01.kupe.niwa.co.nz | 16 | 256 | sat\_cs | EcoConnect satellite processing (ec\_sat03 not yet included) |
| ec-sat02.kupe.niwa.co.nz | 16 | 256 |sat\_cs |as above|
|<span style="color:gray"> ec-sat03.kupe.niwa.co.nz | 16 | 256 |sat\_cs |as above</span> |
|   |   |   |   |   |
| asn010.kupe.niwa.co.nz | 40 | 768 | general\_cs | General &quot;queue&quot; for Rose and executing serial science research jobs arising from the Research VLs. (general-cs01 node not yet included) |
|<span style="color:gray"> general-cs01.kupe.niwa.co.nz  </span>| 16 | 192 |general\_cs | as above|

General &quot;queue&quot; for Rose and executing serial science research jobs arising from the Research VLs.

(general-cs01 node not yet included)
