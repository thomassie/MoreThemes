# This file handles package loading messages

.onAttach <- function(libname, pkgname) {
  packageStartupMessage("MoreThemes package loaded. Themes are ready to use.")
}
