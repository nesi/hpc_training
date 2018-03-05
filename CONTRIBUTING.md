# Contributing to NeSI's HPC training

If you want to want to contribute to the NeSI documentation and training material, you can do so in many ways:
* via this repository, making a Pull Request or pushing diretcly (if you have permissions)
* [openining an issue](https://github.com/nesi/hpc_training/issues)
* emailing training@nesi.org.nz

Please note, all material is organised in lessons (in the `_lesson` folder and then relavant subfolders) and written in GitHub flavoured Markdown. When contributing, please use this tructure and formatting.

## Building the web version locally

Ruby and bundle are required.

In the main repo directory run:

1. `bundle install --path vendor/bundle`
2. `bundle exec jekyll build` (create site contents in the "_site" directory)
3. `bundle exec jekyll server` (run the web server)
4. View web page, probably at: http://127.0.0.1:4000/hpc_training/
