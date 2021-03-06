[![Appveyor build Status](https://ci.appveyor.com/api/projects/status/6n0je31lmiknu398/branch/master?svg=true)](https://ci.appveyor.com/project/KWB-R/qmra-db/branch/master)
[![Travis build Status](https://travis-ci.org/KWB-R/qmra.db.svg?branch=master)](https://travis-ci.org/KWB-R/qmra.db)
[![codecov](https://codecov.io/github/KWB-R/qmra.db/branch/master/graphs/badge.svg)](https://codecov.io/github/KWB-R/qmra.db)
[![Project Status](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/qmra.db)]()
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3339321.svg)](https://doi.org/10.5281/zenodo.3339321)

This package contains a MS ACCESS database, which is used for performing 
quantitative microbial risk assessment (QMRA) within the [AquaNES](https://www.kompetenz-wasser.de/en/project/aquanes-prozesskombinationen-fuer-die-wasseraufbereitung/) project. 

The database was wrapped into an R package for adding the following features: 


- **Database Export** with R functions and 

- **Documention** is generated automatically with R package [pkgdown](https://pkgdown.r-lib.org/) and deployed to GitLab/GitHub and provides
information on the following topics:

    + [Update Database Workflow](articles/update_database.html): how to add data into the 
    database? How to export these? And how can these modifications be proposed
    to the database maintainers?
    
    + [Check Database Content](articles/database_content.html): overview of 
    current database content (based on exported database content into .csv files)
    
    + [NEWS](news.html): for keeping track what has changed (database / R functions)
    and 
    
    + [References](references.html): an help page describing the R functions 
    implemented in this R package more technically
    
    




