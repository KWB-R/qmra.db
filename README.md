[![Appveyor build Status](https://ci.appveyor.com/api/projects/status/github/KWB-R/qmra.db?branch=master&svg=true)](https://ci.appveyor.com/project/KWB-R/qmra-db/branch/master)
[![Travis build Status](https://travis-ci.org/KWB-R/qmra.db.svg?branch=master)](https://travis-ci.org/KWB-R/qmra.db)
[![codecov](https://codecov.io/github/KWB-R/qmra.db/branch/master/graphs/badge.svg)](https://codecov.io/github/KWB-R/qmra.db)
[![Project Status](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/qmra.db)]()
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3339321.svg)](https://doi.org/10.5281/zenodo.3339321)

# qmra.db

This package contains functions for exporting
tables of MS ACCESS database into .csv files.

## Installation

```r
###############################################################################
### 1 Install R Package Downloading and Installing from GitHub
###############################################################################

install.packages("remotes", repos = "https://cloud.r-project.org")

#Sys.setenv(GITHUB_PAT = "mysecret_access_token")
remotes::install_github("r-lib/remotes@18c7302637053faf21c5b025e1e9243962db1bdc")

###############################################################################
### 2 Install R Package qmra.db (with ACCESS DB)
###############################################################################

### 2.1 Specific Release ACCESS DB from our GitHub account, e.g.

#remotes::install_github("kwb-r/qmra.db@0.9.0")

### 2.2 the Latest Development Version 

remotes::install_github("kwb-r/qmra.db")  
```

## Documentation

Release: [https://kwb-r.github.io/qmra.db](https://kwb-r.github.io/qmra.db)

Development: [https://kwb-r.github.io/qmra.db/dev](https://kwb-r.github.io/qmra.db/dev)

## CHANGELOG Moved To [NEWS.md](https://github.com/KWB-R/qmra.db/blob/master/NEWS.md)

Formerly we used the **README.md** for tracking what has change between different versions. 

This changelog is now in [NEWS.md](https://github.com/KWB-R/qmra.db/blob/master/NEWS.md)
