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
## If a library you need is still missing
If you are still missing a necessary library, cloud.gov should produce error messages like this:

>Loading required package: sfError: package or namespace load failed for "sf" in dyn.load(file, DLLpath = DLLpath, ...):<br/>
unable to load shared object '/home/vcap/deps/0/r/library/sf/libs/sf.so':<br/>
libgdal.so.26: cannot open shared object file: No such file or directory<br/>
Error: package "sf" could not be loaded<br/>
Execution halted

To add that library, we will need to know the specific library filename (here, the "libgdal.so.26")

# Disclaimer
The United States Environmental Protection Agency (EPA) GitHub project code is provided on an "as is" basis and the user assumes responsibility for its use.  EPA has relinquished control of the information and no longer has responsibility to protect the integrity , confidentiality, or availability of the information.  Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by EPA.  The EPA seal and logo shall not be used in any manner to imply endorsement of any commercial product or activity by EPA or the United States Government.
