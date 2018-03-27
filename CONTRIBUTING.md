# Contributing to NeSI's HPC training

## Found a problem?

If you find a problem with the training material we are happy to receive Pull Requests with fixes
(see [How to make a contribution](#How to make a contribution)), otherwise let us know what the problem is:

* [open an issue](https://github.com/nesi/hpc_training/issues)
* email [training@nesi.org.nz](mailto:training@nesi.org.nz)

## How to make a contribution

If you want to want to contribute to the NeSI documentation and training material, you can do so in many ways:

1. Create a branch for the changes you are going to make
   * If you have permission to push directly you can create the branch in this repository
   * Otherwise, fork the repository and work in a branch in your fork
2. Make your changes
   * Use a style consistent with the lesson you are editing and the guidelines here
   * Check the the content renders correctly when viewing the web version (for example, 
     see [Building the web version locally](#Bulding the web version locally))
3. Create a Pull Request into the gh-pages branch of the main repository
4. Someone will review your Pull Request and may request additional changes before accepting

## Content structure and style

All material is organised in lessons (in the `_lesson` folder and then relavant subfolders) and
written in GitHub flavoured Markdown. When contributing, please use this structure and formatting
and the following guidelines:

* Don't use a top level heading (`#`) for title of the page -- the title will be generate from the
  lesson metadata
* Use level 2 headings (`##`) and lower (if required) to split the lesson into sections
* Every lesson should start with an "Objectives" section that should lists the lesson's objectives

## Building the web version locally

Ruby and bundle are required.

In the main repo directory run:

1. `bundle install --path vendor/bundle`
2. `bundle exec jekyll build` (create site contents in the "_site" directory)
3. `bundle exec jekyll server` (run the web server)
4. View web page, probably at: http://127.0.0.1:4000/hpc_training/
