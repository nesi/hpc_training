---
layout: post
title: Working with custom packages
permalink: /lessons/introduction/custom-packages/
chapter: introduction
---

# The material below is just copied from Pan materials - needs work to adapt to new platforms

### Working with R packages
Detailed NeSI [documentation on working with R packages](https://support.nesi.org.nz/hc/en-gb/articles/209338087-R#dealing-with-packages)

Tom Kelly (The University of Otago PhD graduate) [developed a number of scripts and examples](https://github.com/TomKellyGenetics/install.nesi) on how to install R packages on NeSI.

### Working with Python packages
Detailed NeSI [documentation on working with Python packages](https://support.nesi.org.nz/hc/en-gb/articles/207782537-Python#third-party-modules)


### Example of installing a custom R package



```
> install.packages("tidyverse")
Warning in install.packages("tidyverse") :
  'lib = "/gpfs1m/apps/easybuild/RHEL6.3/westmere/software/R/3.4.2-gimkl-2017a/lib64/R/library"' is not writable
Would you like to use a personal library instead?  (y/n)
```

```
Would you like to create a personal library
~/R/x86_64-pc-linux-gnu-library/3.4
to install packages into?  (y/n)
```


```
--- Please select a CRAN mirror for use in this session ---
Secure CRAN mirrors

 1: 0-Cloud [https]                   2: Algeria [https]
 3: Australia (Canberra) [https]      4: Australia (Melbourne 1) [https]
 5: Australia (Melbourne 2) [https]   6: Australia (Perth) [https]
 7: Austria [https]                   8: Belgium (Ghent) [https]
 9: Brazil (PR) [https]              10: Brazil (RJ) [https]
11: Brazil (SP 1) [https]            12: Brazil (SP 2) [https]
13: Bulgaria [https]                 14: Chile 1 [https]
15: Chile 2 [https]                  16: China (Guangzhou) [https]
17: China (Lanzhou) [https]          18: Colombia (Cali) [https]
19: Czech Republic [https]           20: Denmark [https]
21: East Asia [https]                22: Ecuador (Cuenca) [https]
23: Estonia [https]                  24: France (Lyon 1) [https]
25: France (Lyon 2) [https]          26: France (Marseille) [https]
27: France (Montpellier) [https]     28: France (Paris 2) [https]
29: Germany (Göttingen) [https]      30: Germany (Münster) [https]
31: Greece [https]                   32: Iceland [https]
33: Indonesia (Jakarta) [https]      34: Ireland [https]
35: Italy (Padua) [https]            36: Japan (Tokyo) [https]
37: Malaysia [https]                 38: Mexico (Mexico City) [https]
39: Norway [https]                   40: Philippines [https]
41: Serbia [https]                   42: Spain (A Coruña) [https]
43: Spain (Madrid) [https]           44: Sweden [https]
45: Switzerland [https]              46: Turkey (Denizli) [https]
47: Turkey (Mersin) [https]          48: UK (Bristol) [https]
49: UK (Cambridge) [https]           50: UK (London 1) [https]
51: USA (CA 1) [https]               52: USA (IA) [https]
53: USA (KS) [https]                 54: USA (MI 1) [https]
55: USA (OR) [https]                 56: USA (TN) [https]
57: USA (TX 1) [https]               58: Vietnam [https]
59: (other mirrors)

Selection:

```

And then, there is a LOT of output information on your screen to finally arrive to:

```
** testing if installed package can be loaded
* DONE (tidyverse)

The downloaded source packages are in
    ‘/tmp/RtmpR64gHN/downloaded_packages’
```

But let's see what is in our home directory:

```
[apaw363@login-01 ~]$ ls R/x86_64-pc-linux-gnu-library/3.4/
broom       cli     dbplyr   hms        psych   rematch  rmarkdown   rvest      whisker
callr       clipr   forcats  lubridate  readr   reprex   rprojroot   selectr    xml2
cellranger  crayon  haven    modelr     readxl  rlang    rstudioapi  tidyverse
```
