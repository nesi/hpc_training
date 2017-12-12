# array-analysis.R
#
# Code is from readings-02.R as part of SWC lesson http://swcarpentry.github.io/r-novice-inflammation/05-cmdline/ 
#
# Date: 7 March 2017
#
# first argument to script is filename
# file is read in and the mean per patient is outputted
main <- function() {
  args <- commandArgs(trailingOnly = TRUE)
  filename <- args[1]
  dat <- read.csv(file = filename, header = FALSE)
  mean_per_patient <- apply(dat, 1, mean)
  cat(mean_per_patient, sep = "\n")
}

main()
