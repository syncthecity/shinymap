homedir <- Sys.getenv("HOME")
udunits_dir <- file.path(Sys.getenv("HOME"), "udunits")
system(paste0("mkdir ", udunits_dir))
system(paste0("wget --directory-prefix=", udunits_dir, " ftp://ftp.unidata.ucar.edu/pub/udunits/udunits-2.2.26.tar.gz"))
owd <- getwd()
setwd(udunits_dir)
system("tar xzvf udunits-2.2.26.tar.gz")
setwd(file.path(udunits_dir, "udunits-2.2.26"))
system(paste0("./configure --prefix=", udunits_dir, "/local"))
system("make")
system("make install")
setwd(owd)
Sys.setenv(LD_LIBRARY_PATH=paste0(Sys.getenv("LD_LIBRARY_PATH"), ":", udunits_dir, "/local/lib"))
install.packages("udunits2", 
                 type = "source",
                 configure.args = c(paste0("--with-udunits2-include=", udunits_dir, "/local/include"), 
                                    paste0("--with-udunits2-lib=", udunits_dir, "/local/lib")),
                 repos = "http://cran.rstudio.com")
dyn.load(paste0(udunits_dir, "/local/lib/libudunits2.so.0"))
install.packages("devtools")
devtools::install_github("r-quantities/units", 
                         args=paste0("--configure-args=\"--with-udunits2-lib=", udunits_dir, 
                                     "/local/lib --with-udunits2-include=", udunits_dir, "/local/include\""))