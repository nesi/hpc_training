---
layout: page
title: FAQ
permalink: /sections/faq/
chapter: faq
---

**How many GPUs will be available?** <br/>
HPC1 will have 8 GPGPUs (Nvidia P100) for general use. There will also be 8 GPGPUs (P100) on HPC2 for visualisation and computational work. The platform is designed to add more GPGPUs in the future, depending on demand.

**What is the max storage that can be requested per project?**<br/>
This will be determined on a case-by-case basis based on users’ need. The new platforms provide for significantly more storage (~7 PB of high performance storage, and ~6 PB of nearline/offline archive storage) than that available on the combined Pan and Fitzroy platforms. It is expected that the issues users experienced with managing limited quotas will be much less of an issue on the new platforms. Some file systems will have quotas (this will be covered in training) but it is unlikely to have quota on scratch space used for computation. [more details.](https://www.nesi.org.nz/services/high-performance-computing/platforms/new-infrastructure-platform)

**Will scp/Globus work with 2-factor authentication?**<br/>
SCP works as with SSH, so it will need 2-factor authentication. We are hoping to install a caching mechanism that will avoid the need to re-authenticate each individual session within a short time interval, similar to, e.g., “sudo” on Linux. We’re working with the Globus team on authentication, but in the short term it is unlikely that 2-factor authentication will be required.

**How will scripted machine to machine workflows work with 2-factor authentication?**<br />
This will need to be discussed on a per-case basis. Please contact us if you need automated access to the HPC of some form.

**What is the expected migration time frame to the new platform from Pan?**<br/>
Pan’s replacement (HPC1) will be in place approx March ‘18. Both Pan and HPC1 will run in parallel during migration and before Pan shuts down.
FitzRoy will shut down mid November, so migration to Kupe (HPC3) will be complete before then.
Please contact support@nesi.org.nz if you need migration support.

**How big (CPUs, memory, storage) are these new HPCs?**<br />
[Please see the technical details](https://www.nesi.org.nz/services/high-performance-computing/platforms/new-infrastructure-platform)

**Will the login node have access to the Internet to retrieve source code from GitHub or packages from repos, such as bioconda?**<br />
Yes, you will be able to access online repositories, e.g., via “git clone”, “svn checkout”, or “conda install”.

**Will new projects (e.g. start in Jan. 2018) be migrated earlier or should we allow for a disruption in transfer around March for these?**<br/>
We are focused on smooth transitions for existing / in flight projects, so we will work with you when the time comes. The jobs cannot be live migrated, so migration will need to happen with a break between production runs. There will likely be a short freeze before this migration where new projects won’t be accepted - thinking about 3 to 4 weeks prior.

**Will everyone need to use 2-factor authentication?**<br/>
Yes, everyone will need that. There will be a web-based interface for those who don’t have a smartphone.

**Follow-up globus question: Will there be support for software and data migration from overseas server? (without the need of Gdrive in between).**<br />
Globus requires two endpoints, e.g., at a university and on the NeSI HPC. You would need to contact IT support at your organisation if there is no Globus endpoint. Feel free to also contact us on support@nesi.org.nz and we can work directly with you to find a solution.

**There are more machines and memory available on the new platform (e.g. compared with Pan), how many new users are expected? (i.e. how will this translate to job wait times? Will we expect improvements?)**<br />
The new HPCs will come with a significant increase in capacity, and also additional gains in performance, so there will be little by way of queues, initially, even with new HPC users coming in.

**Will all the data in a specified storage be backed up and what is the maximum size?**<br />
This depends on the file space - some are always backed up (such as home directories), while others are never backed up (such as scratch space for runtime output). There will also be an archiving system. Size limits depend on file space, e.g., home directories should not contain very large files. Further details will be announced in user training sessions.

**Will there be any time during the transition we will not be able to use either pan or HPC1?**<br />
There will be an overlap period where both Pan and HPC1 run in parallel, so there will be no downtime where no jobs can run.

**Also will we be able to access our project files during any transition? Is it best to make a back up of any data currently on Pan before some date?** <br/>
Yes, files will always be available. Backups are not necessary for the migration, but they are always a good idea.

**New users: My university has institutional access, is my first step to apply for a project from NeSI and can I do that now before the HPCs are available?**<br />
Yes you can apply now for an allocation. It will be converted as we migrate to the new platform. The number of core hours will be reduced because of higher performance per core on HPC1/HPC2 compared to Pan/Fitzroy.

**Will jobs requiring large memory be given priority to large memory machines over jobs that could run on smaller memory machines (or will there be a way to apply for this)?**<br />
Scheduler configuration that will manage these resources is still being finalised, but it is expected that such prioritisation will be in place. Resource selection will be made according to job requirements (number cores and nodes, memory usage etc.), and there may also be additional queues for particular job types.

**Currently users cannot check their current total core hour usage under each NeSI project. Will this be enabled for the new clusters?** <br/>
We are currently developing an interface which will allow users to see where they are at against their allocation. We are aiming to have this available early next year.

**Can we request standalone software like SMRTLink portal on HPC?**<br />
We can help you with building and installing additional software on the HPC, please contact us on support@nesi.org.nz.

**I spotted a mention of 500MB data storage in one of the slides - was this correct, or was it meant to be 500GB?** <br/>
This might have been the Globus slide, where using Globus is recommended for transferring more than 500MB of data.

**How much temporary (short term) storage can projects get?**<br />
Projects should be able to scale up to large amounts of storage. Please talk to us if you need a lot (e.g., hundreds of TB), so that we can work with you to meet your requirements.

**Where can I get a a copy of the slides as well as the recording of the webinar presenting new NeSI platforms?**<br/>
* [You can view the webinar online.](https://youtu.be/ldv9Tpoz_78)
* [And the slides](https://docs.google.com/presentation/d/1hw0Rp60VAgJEYSaMHly1hN1u7DxV2YpsYznrHMIzRYI/edit?usp=sharing).
