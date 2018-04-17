---
layout: page
title: FAQ
permalink: /sections/faq/
chapter: faq
order: 5
---

# The new platforms

**How big (CPUs, memory, storage) are the new HPC platforms?**<br />
They provide a significant increase in performance over the existing platforms. Please see the [new platform technical details](https://www.nesi.org.nz/services/high-performance-computing/platforms/new-infrastructure-platform) for more information.

**How many GPUs will be available?** <br/>
Mahuika (HPC1) will have 8 GPGPUs (Nvidia P100) for general use. There will also be 8 GPGPUs (P100) on Maui (HPC2) for visualisation and computational work. The platform is designed to add more GPGPUs in the future, depending on demand.

**There are more nodes/cores and memory available on the new platform (e.g. compared with Pan), how many new users are expected? (i.e. how will this translate to job wait times? Will we expect improvements?)**<br />
The new HPCs will come with a significant increase in capacity, and also additional gains in per processor performance. We anticipate a significant reduction in queue wait times initially. Queue wait times will be impacted by both the number of new users on the system as well as by the rate at which current users submit jobs. The new platforms provide an excellent mechanism for researchers to scale up their research, so we expect current users to use more resources. At the same time, we don't know how many new users the new platforms will attract. As a result, it is very difficult to predict how the load (and therefore queuing times) will evolve once the new systems are in production and users start to take advantage of the new capabilities.

# Managing projects

**My university has institutional access, is my first step to apply for a project from NeSI and can I do that now before the HPCs are available?**<br />
Yes you can apply now for an allocation. It will be converted as we migrate to the new platform. The number of core hours will be reduced because of higher performance per core on Mahuika/Maui compared to Pan/FitzRoy.

**Will new projects (e.g. start in Jan. 2018) be migrated earlier or should we allow for a disruption in transfer around March for these?**<br/>
We are focused on smooth transitions for existing / in flight projects, so we will work with you when the time comes. Jobs cannot be live migrated, so migration will need to happen with a break between production runs. There will likely be a short freeze before this migration where new projects won’t be accepted - thinking about 3 to 4 weeks prior.

# Project and data migration

**What is the expected migration time frame to the new platform from Pan?**<br/>
Installation of Pan’s replacement (Mahuika) will begin in late February 2018. Both Pan and Mahuika will run in parallel during migration and before Pan shuts down in May 2018.
FitzRoy was shut down on January 09, 2018 and all FitzRoy users have been migrated to Kupe.
Please contact <a href="mailto:support@nesi.org.nz">support@nesi.org.nz</a> if you need migration support.

**Will we be able to access our project files during any transition? Is it best to make a back up of any data currently on Pan before some date?** <br/>
Yes, files will always be available. There will likely be a period where changing files will not be allowed in order to ensure files are transferred without corruption. Backups are not necessary for the migration, but they are always a good idea. 

**Will there be any time during the transition we will not be able to use either Pan or HPC1?**<br />
There will be an overlap period where both Pan and Mahuika run in parallel, so there will be no downtime where no jobs can run.

# Accessing the platforms

**Will the login node have access to the Internet to retrieve source code from GitHub or packages from repos, such as bioconda?**<br />
Yes, you will be able to access online repositories, e.g., via “git clone”, “svn checkout”, or “conda install”.

**Will everyone need to use 2-factor authentication?**<br/>
Yes, everyone will need to use 2-factor authentication. There will be a web-based interface for those who don’t have a smartphone.

**Will data transfer mechanisms (scp/Globus) work with 2-factor authentication?**<br/>
SCP uses the same authentication as SSH, so it will need 2-factor authentication. We are hoping to install a caching mechanism that will avoid the need to re-authenticate each individual session within a short time interval, similar to, e.g., “sudo” on Linux. We’re working with the Globus team on authentication, but in the short term it is unlikely that 2-factor authentication will be required.

**How will scripted machine to machine workflows work with 2-factor authentication?**<br />
This will need to be discussed on a per-case basis. Please contact <a href="mailto:support@nesi.org.nz">support@nesi.org.nz</a> if you need automated access to the HPC in some form.

**Will there be support for data transfer directly from external (including overseas) servers?**<br />
Yes, transfers from external collaborators will be supported. The recommended mechanism for large data transfers is through Globus. Globus requires two endpoints, e.g., at a collaborator institution and on the NeSI HPC. You would need to contact IT support at your institution if there is no Globus endpoint. Feel free to also contact us on support@nesi.org.nz and we can work directly with you to find a solution.

# Data storage

**What is the maximum storage that can be requested per project?**<br/>
This will be determined on a case-by-case basis based on a project's need. The new platforms provide for significantly more storage (~7 PB of high performance storage, and ~6 PB of nearline/offline storage) than that available on the combined Pan and FitzRoy platforms. It is expected that the issues users experienced with managing limited quotas (in particular on Pan) will be much less of an issue on the new platforms. In particular, it will no longer be necessary to move data between the two system as was necessary with Pan/FitzRoy. Some file systems will have quotas (this will be covered in training) but there is unlikely to be a quota on the scratch (or /nobackup) space used for computation. [more details.](https://www.nesi.org.nz/services/high-performance-computing/platforms/new-infrastructure-platform)

**How much temporary (short term) storage can projects get?**<br />
Projects should be able to scale up to large amounts of storage, in particular for short periods of time. Please contact <a href="mailto:support@nesi.org.nz">support@nesi.org.nz</a> so that we can work with you to meet your requirements.

**Will all the data in a specified file system be backed up?**<br />
This depends on the file system - some file systems such as the /home and /project directories will be backed up, while others will not be backed up (such as the /nobackup file system for runtime output). There will also be a hierarchical nearline storage system for storage of data that does not require high performance disk.

# Managing allocations

**Will jobs requiring large memory be given priority to large memory machines over jobs that could run on smaller memory machines (or will there be a way to apply for this)?**<br />
Scheduler configuration that will manage these resources is still being finalised, but it is expected that such prioritisation will be in place. Resource selection will be made according to job requirements (number cores and nodes, memory usage etc.), and there may also be additional queues for particular job types.

**Currently users cannot check their current total core hour usage under each NeSI project. Will this be enabled for the new clusters?** <br/>
We are currently developing an interface which will allow users to see where they are at against their allocation. We are aiming to have this available for the new clusters.

**Can we request custom software on the new HPCs?**<br />
We can help you with building and installing additional software on the HPC, please contact us at <a href="mailto:support@nesi.org.nz">support@nesi.org.nz</a>.

# More information

**Where can I get a copy of the slides and recording of the webinar presenting new NeSI platforms?**<br/>
We have hosted two webinars on the new systems:
<br>October 2017 - Overview of the Systems
* [You can view the webinar online.](https://youtu.be/ldv9Tpoz_78)
* [And the slides](https://docs.google.com/presentation/d/1hw0Rp60VAgJEYSaMHly1hN1u7DxV2YpsYznrHMIzRYI/edit?usp=sharing).
<br><br>February 2018 - User Q&A
* [You can view the webinar online.](https://www.youtube.com/watch?v=X-Vmu69yTo4&feature=youtu.be)
* [And the slides](https://drive.google.com/file/d/1yBJ5aBJQj_7WUQeBbHSVfPkWcY-OYXoF/view)
