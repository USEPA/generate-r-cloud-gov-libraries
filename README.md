# Generate R Cloud.gov Libraries
This repo is built to generate necessary libraries to use alongside the
USEPA CRAN mirror for cloud.gov posted here: https://github.com/USEPA/cflinuxfs3-CRAN

Place the lib folder from this repo in your R Shiny code directory for use on cloud.gov.

Additionally, add the following to your first R code (in EPA we typically use a file called shiny.R):
```
library_path <- paste("Library Path: ", Sys.getenv(c("LD_LIBRARY_PATH")))
print(paste("LD_LIBRARY_PATH: ", library_path))

lib_dir <- '/home/vcap/deps/0/r/lib'
local_lib_dir <- 'lib'

if(dir.exists(lib_dir))
{
  # Get the list of libs
  lib_tars <- list.files(local_lib_dir)
  lib_tars <- paste(local_lib_dir, lib_tars, sep="/")

  print(paste("Local libs: ", lib_tars))
  print(paste("Working directory: ", list.files(getwd())))

  # Copy the files to the lib_dir
  for(i in 1:length(lib_tars)) {untar(lib_tars[i], exdir = lib_dir)}

  Sys.setenv(PROJ_LIB=lib_dir)
}

print(list.files(lib_dir))
```
