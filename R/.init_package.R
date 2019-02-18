
package  <- "qmra.db"

# Set the path to your new package
pkg_dir <- getwd()

stopifnot(basename(pkg_dir) == package)

# Create directory for R package
kwb.pkgbuild::create_pkg_dir(pkg_dir)

# Create a default package structure
withr::with_dir(pkg_dir, {kwb.pkgbuild::use_pkg_skeleton(package)})

kwb.orcid::get_kwb_orcids()

author <- list(
  name = "Michael Rustler",
  orcid = "0000-0001-9134-2871",
  url = "https://mrustl.de"
)

description <- list(
  name = package,
  title = "Database Backend for AQUANES QMRA Webapp",
  desc  = paste(
    "This package contains functions for exporting tables of MS ACCESS database", 
    "into .cSv files")
  )


kwb.pkgbuild::use_pkg(
  author,
  description,
  version = "0.9.0",
  stage = "maturing"
)


kwb.pkgbuild::use_gitlab_ci_pkgdown()


pkg_dependencies <- c("kwb.utils", "kwb.datetime", "kwb.event", "kwb.plot", 
                      "kwb.read", "kwb.monitoring", "kwb.logger")

sapply(pkg_dependencies, usethis::use_package)

sapply(sprintf("github::kwb-r/%s", pkg_dependencies), desc::desc_add_remotes)
