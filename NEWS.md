# [qmra.db 0.9.0](https://github.com/KWB-R/qmra.db/releases/tag/v0.9.0) <small>2019-02-21</small>

**BREAKING CHANGES**: ***due to converting repo as R package***

Moved from [/](https://github.com/KWB-R/qmra.db/tree/master/) into 
[/inst/database](https://github.com/KWB-R/qmra.db/tree/master/inst) directory 
(required for R Package):

* MS ACCESS database ([qmra-db.accdb](https://github.com/KWB-R/qmra.db/tree/master/inst/database)), 

* folder: [qmra-db_accdb](https://github.com/KWB-R/qmra.db/tree/master/inst/database/qmra-db_accdb) 
(exported MS ACCESS content as .csv)

* folder: [rawdata](https://github.com/KWB-R/qmra.db/tree/master/inst/database/rawdata)  (Excel files received from @PatrickSmeetsKWR and imported into MS ACCESS DB by @mrustl), see NEWS entries of prior qmra.db releases

* folder: [ui-workflow](https://github.com/KWB-R/qmra.db/tree/master/inst/database/ui-workflow)  
(flowchart related to development of QMRA webapp user interface by @mrustl)


R files: 

* Moved "db-initialGeneration.R" from [/](https://github.com/KWB-R/qmra.db/tree/master/) into [data-raw](https://github.com/KWB-R/qmra.db/tree/master/data-raw) folder


* Moved "db-export.R" from [/](https://github.com/KWB-R/qmra.db/tree/master/) into [R](https://github.com/KWB-R/qmra.db/tree/master/data-raw) folder. In addition 
added Rscript [.init_package.R](https://github.com/KWB-R/qmra.db/commit/dde0576ab57575135a1e16a81f752bf1bce05d98#diff-990bb284e3185198984dba48ab42ba2e)" describing workflow for preparing this 
R package.


tbl_inflow: 

* Use "log10_norm" as default for all data entries (instead of "uniform") in MS ACCESS DB  and export csv files (#2), which is now 
implemented in R package [kwb.qmra](https://github.com/kwb-r/kwb.qmra) (see [issue #14](https://github.com/KWB-R/kwb.qmra/issues/14) and [issue #17](https://github.com/KWB-R/kwb.qmra/issues/17))


***Prepare public release (#1)***

* Convert repository into R package for improved documentation and 
  also offers possiblity to add Rmarkdown export of MS ACCESS DB     
  (feature asked by @daniel-wicke)
  
* Add authors: @wseis @PatrickSmeetsKWR and Aquanes as "funder"

* Added a `NEWS.md` file to track changes to the package. Based on README.md but renamed original names to Github usernames

* see https://style.tidyverse.org/news.html for writing a good `NEWS.md`


# [qmra.db 0.8.0](https://github.com/KWB-R/qmra.db/releases/tag/v0.8.0) <small>2018-11-12</small>

"rawdata" folder: 
* added @PatrickSmeetsKWR's changes made in EXCEL files "tbl_logremoval.xlsx" and "tbl_treatment.xlsx"(sent to @mrustl on 
2018-11-08 via email) in "rawdata" folder

tbl_treatment: 
* added TreatmentDescription: from @PatrickSmeetsKWR's "tbl_logremoval.xlsx" (sent on 2018-11-08 via email)
* renamed/added TreatmentNames: UV disinfection 20 mJ/cm2, drinking and UV disinfection 40 mJ/cm2, drinking

tbl_logRemoval
* deleted entries for TreatmentID 15 (RO) from WHO (2011) (Reference: 8), now default RO data are based on NSF/ANSI 419  validation (referenceID = 47)



# [qmra.db 0.7.1](https://github.com/KWB-R/qmra.db/releases/tag/v0.7.1) <small>2018-10-11</small>

tbl_treatment: 
* added TreatmentGroup "Wetland" 
* added TreatmentDescription" (from WHO 2017: http://www.who.int/water_sanitation_health/publications/drinking-water-quality-guidelines-4-including-1st-addendum/en/)
* deleted TreatmentID 6 -> "Membrane filtration (micro, ultra-, nanofiltration, reverse osmosis)"

tbl_logRemoval
* deleted entries for TreatmentID 6 from WHO (2011)

# [qmra.db 0.7.0](https://github.com/KWB-R/qmra.db/releases/tag/v0.7.0) <small>2018-10-09</small>

tbl_treatment: renamed treatment processes
* UV ->  UV disinfection, drinking water
* UV radiation -> UV disinfection, wastewater
* Ozone -> Ozonation, drinking water
* Ozonation -> Ozonation, wastewater
* deleted TreatmentID 29 (no further entries) 


tbl_references: 
* added data from @PatrickSmeetsKWR`s EXCEL files (tbl_logRemoval_181008.xlsx, 
tbl_inflow_181008.xlsx) 

tbl_waterSource
* renamed WaterSourceID 7 from "drinking water" to "groundwater" and adapted WaterSourceDescription field accordingly

tbl_ingestion
* added data from @PatrickSmeetsKWR`s EXCEL file (Book1.xlsx, renamed by @mrustl to tbl_ingestion.xlsx)
* added raw data (used for updating DB) to sub-folder: rawdata/tbl_ingestion.xlsx
* added WaterUseID 9 (-> domestic use, washing maschine)

tbl_inflow: 
* added data from @PatrickSmeetsKWR`s EXCEL file (tbl_inflow_181008.xlsx)

   + new columns: mean, alpha, beta, distribution,      
     PathogenInReference,	Notes   
   
   + added only data values for mean, alpha, beta in cases these are       either not to be assumed the same as min/max (i.e. for   
     alpha/beta) or not calcululated i.e. mean = (min+max)/2
     
   + distribution: is set to "uniform" (as default)
- added raw data (used for updating DB) to sub-folder: rawdata/tbl_inflow_181008.xlsx


tbl_logRemoval

* added corrected data (PathogenGroupID!) from @PatrickSmeetsKWR`s EXCEL file 
  (tbl_logRemoval_181008.xlsx):
   + new columns: mean, alpha, beta, distribution, Notes
   + no data values entered for mean, alpha, beta as these are either are always 
   to be assumed the same as min/max (i.e. alpha/beta) or calculated, i.e. 
   mean = (min+max)/2
   + distribution: is set to "uniform" (as default)
* added raw data (used for updating DB) to sub-folder: rawdata/tbl_logRemoval_181008.xlsx
* bugfix: corrected wrong ReferenceID for DEMOWARE reference 


# [qmra.db 0.6.1](https://github.com/KWB-R/qmra.db/releases/tag/v0.6.1) <small>2018-09-26</small>
tbl_pathogenGroup: 
* reset default PathogenID for protozoa to Cryptosporidium (ParameterID=34) instead of Giardia (ParameterID=36) 

conversion of ACCESS mdb to mySQL: https://dev.mysql.com/doc/workbench/en/wb-migration-database-access.html

# [qmra.db 0.6](https://github.com/KWB-R/qmra.db/commit/b30e91c65dbe0134402c143e16b365b23c629401) <small>unreleased</small>

Based on v0.4 after integrating most modifications performed by @PatrickSmeetsKWR in v0.5 but without rename/deletion of 
currently unneeded pathogens from multiple MS ACCESS tables. 

tbl_pathogenGroup: 
added a new column “DefaultPathogenID” which contains a default PathogenID (see look-up table "tbl_pathogen") for each pathogen group. Current defaults are: 
* Viruses: Rotavirus (PathogenID = 32), 
* Bacteria: Campylobacter(PathogenID = 3) and 
* Protozoa: Giardia (PathogenID = 36)

tbl_inflow: 
added @PatrickSmeetsKWR`s adaptations in DB version v0.5 (but keeping all pathogen names of DB v0.4). In addition set default distribution to "uniform" instead of "lognormal". 

Reason: implementation of "lognorm" function in R package "kwb.qmra" needs to be re-programmed/tested in order to work properly 
(current test by myself gives unreasonable results!). Scheduled to be done after GA in Greece by @mrustl. In addition also other distributions requiring "beta" or "alpha" parameters need to be added in the R package.

* tbl_health: rolled-back to table used in DB version 0.4 (containing all pathogen names)

* tbl_waterSource: added @PatrickSmeetsKWR`s adaptations of v0.5 (but keeped naming for "sewage, raw", "sewage, treated"
for consistency reasons)

* tbl_doseResponse: rolled-back to table used in DB version 0.4 (containing all pathogen names)

* tbl_exposure: renamed to "tbl_ingestion" as proposed by @PatrickSmeetsKWR


# [qmra.db 0.5](https://github.com/KWB-R/qmra.db/releases/tag/v0.5) <small>2018-09-23</small>
Based on v0.4 (changes by @PatrickSmeetsKWR):

tbl_inflow Added new parameters to allow for stochastic distribution parameters to be entered
"distribution"= the type of stochastic distribution to describe uncertainty about mean concentration
"alpha" "beta" = the parameters of this distribution, assuming that no more than two parameter distributions will be used. e.g. with normal distribution alpha is the mean and beta is the standard deviation

@PatrickSmeetsKWR`s questions for @mrustl: align naming of distributon type with R or make sure R can translate it. Also allow for input of these parameters through the .csv file
Check: entered now as lognormal, entered values as normal distributed over log concentration (mean=min+max/2 stdev=mean-min in log values)

tbl_inflow Changed Field size of min, max, alpha, beta to "Double" to allow for digits in the values (concentrations <1/l)

tbl_waterSource: changed field names for consistency and added descriptions of water sources 

tbl_pathogen: added "viruses" "bacteria" and "protozoa" since this is the level that selections are made
all other pathogens were removed from this table for this level assessment I saved original table: "Copy Of tbl_pathogen"

tbl_doseResponse: added viruses (rotavirus) bacteria (campy) protozoa (crypto) 
Note: need to check which one was chosen by @mrustl since there are multiple D-R for some organisms

tbl_health: changed to viruses (rotavirus) bacteria (campy) protozoa (crypto)

Note: Why is tbl_pathogen:tbl_doseResponse a one to many? each pathogenID has a single dose response. So these don't need to be in separate tables
Note: Log removal is now based on pathogen type, however it should be per pathogen (adenovirus different from enterovirus etc. althogh some will be the same due to lack of detail)
Note: the front end selects data from databases based on user selection. It then combines all relevant information from databases in csv files for the R-tool. For the front end it keeps other data to store the scenario and later on make graphs etc.

tbl_exposure changed name to "tbl_ingestion" since exposure is generally used for the pathogens and we want to show that exposure as output. e.g. WHO QMRAdoc "magnitude and frequency of exposure to reference pathogens via the defined exposure pathways and hazardous
events" although the term isn't used consistently (e.g. Table A5.4)

@PatrickSmeetsKWR`s questions for @mrustl: the .csv file "exposure" is very different from "tbl_exposure". Please clarify what should be sent from the front end to the R-tool:
- is the number of events per year a value or a distribution?
- is the volume per event a value or a distribution?
- where do we set the number of repetitions (Monte Carlo simulation)?


Note that we allow only one intended use, for other applications the user needs to do a separate run of the model


# [qmra.db 0.4](https://github.com/KWB-R/qmra.db/releases/tag/v0.4) <small>2018-09-14</small>

Based on v0.3

Added new parameter "...Description" in the following tables:
* tbl_waterSource
* tbl_pathogen
* tbl_pathogenGroup
* tbl_exposure 
* tbl_guideline
* tbl_treatment


Updated DB structure overview with new parameter


# [qmra.db 0.3](https://github.com/KWB-R/qmra.db/releases/tag/v0.3) <small>2018-09-07</small>

Status after internal QA with DB expert @hsonne:

* Improved naming of tables and columns
* Added referential integrety for table connections
* Updated DB structure 
* Updated UI flowchart ("/ui-workflow") and added relevant

ACCESS table names for each step

# [qmra.db 0.2](https://github.com/KWB-R/qmra.db/releases/tag/v0.2) <small>2018-08-31</small>

Based on v0.1

* modified "tbl_inflow" with R script "db-scheme-for-kwb-qmra.v0.2.R"
* slightly modified MS ACCESS tables manually (e.g. defining "key" columns)


# [qmra.db 0.1](https://github.com/KWB-R/qmra.db/releases/tag/v0.2) <small>2018-07-05</small>

MS Access database "qrma-db.accdb" generated with R script "db-initialGeneration.R" containing first draft of MS ACCESS database and R script using data from Old Ford Public Irrigation scenario for generating and exporting the tables to ACCESS

All tables/queries in DB are exported with R script "db-export.R" as .csv files into subfolder "qmra-db_accdb"
