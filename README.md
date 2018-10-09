# v0.7.0

tbl_treatment: renamed treatment processes
- UV ->  UV disinfection, drinking water
- UV radiation -> UV disinfection, wastewater
- Ozone -> Ozonation, drinking water
- Ozonation -> Ozonation, wastewater
- deleted TreatmentID 29 (no further entries) 


tbl_references: 
- added data from Patrick`s EXCEL files (tbl_logRemoval_181008.xlsx, 
tbl_inflow_181008.xlsx) 

tbl_waterSource
- renamed WaterSourceID 7 from "drinking water" to "groundwater" and adapted 
WaterSourceDescription field accordingly
- added WaterSourceID 9 (domestic use, washing maschine)

tbl_ingestion
- added data from Patrick`s EXCEL file (Book1.xlsx, renamed by Michael to 
tbl_ingestion.xlsx)
- added raw data (used for updating DB) to sub-folder: rawdata/tbl_ingestion.xlsx


tbl_inflow: 
- added data from Patrick`s EXCEL file (tbl_inflow_181008.xlsx)
   + new columns: mean, alpha, beta, distribution, PathogenInReference,	Notes
   + added only data values for mean, alpha, beta in cases these are either not 
   to be assumed the same as min/max (i.e. for alpha/beta) or not calcululated
   i.e. mean = (min+max)/2
   + distribution: is set to "uniform" (as default)
- added raw data (used for updating DB) to sub-folder: rawdata/tbl_inflow_181008.xlsx


tbl_logRemoval
- added corrected data (PathogenGroupID!) from Patrick`s EXCEL file 
  (tbl_logRemoval_181008.xlsx):
   + new columns: mean, alpha, beta, distribution, Notes
   + no data values entered for mean, alpha, beta as these are either are always 
   to be assumed the same as min/max (i.e. alpha/beta) or calculated, i.e. 
   mean = (min+max)/2
   + distribution: is set to "uniform" (as default)
- added raw data (used for updating DB) to sub-folder: rawdata/tbl_logRemoval_181008.xlsx
- bugfix: corrected wrong ReferenceID for DEMOWARE reference 


# v0.6.1

tbl_pathogenGroup: reset default PathogenID for protozoa to Cryptosporidium (ParameterID=34) instead of Giardia (ParameterID=36) 

conversion of ACCESS mdb to mySQL: https://dev.mysql.com/doc/workbench/en/wb-migration-database-access.html

# v0.6

Based on v0.4 after integrating most modifications performed by Patrick in v0.5 but without rename/deletion of 
currently unneeded pathogens from multiple MS ACCESS tables. 

tbl_pathogenGroup: added a new column “DefaultPathogenID” which contains a default PathogenID (see look-up 
table "tbl_pathogen") for each pathogen group. Current defaults are: 
- Viruses: Rotavirus (PathogenID = 32), 
- Bacteria: Campylobacter(PathogenID = 3) and 
- Protozoa: Giardia (PathogenID = 36)

- tbl_inflow: added Patrick`s adaptations in DB version v0.5 (but keeping all pathogen names of DB v0.4). 
In addition set default distribution to "uniform" instead of "lognormal". Reason: implementation of 
"lognorm" function in R package "kwb.qmra" needs to be re-programmed/tested in order to work properly 
(current test by myself gives unreasonable results!). Scheduled to be done after GA in Greece by Michael.
In addition also other distributions requiring "beta" or "alpha" parameters need to be added in the R 
package.
- tbl_health: rolled-back to table used in DB version 0.4 (containing all pathogen names)
- tbl_waterSource: added Patrick`s adaptations of v0.5 (but keeped naming for "sewage, raw", "sewage, treated"
for consistency reasons)
- tbl_doseResponse: rolled-back to table used in DB version 0.4 (containing all pathogen names)
- tbl_exposure: renamed to "tbl_ingestion" as proposed by Patrick


# v0.5

Based on v0.4 (changes by Patrick):

tbl_inflow Added new parameters to allow for stochastic distribution parameters to be entered
"distribution"= the type of stochastic distribution to describe uncertainty about mean concentration
"alpha" "beta" = the parameters of this distribution, assuming that no more than two parameter distributions will be used. e.g. with normal distribution alpha is the mean and beta is the standard deviation
Michael: align naming of distributon type with R or make sure R can translate it. Also allow for input of these parameters through the .csv file
Check: entered now as lognormal, entered values as normal distributed over log concentration (mean=min+max/2 stdev=mean-min in log values)

tbl_inflow Changed Field size of min, max, alpha, beta to "Double" to allow for digits in the values (concentrations <1/l)

tbl_waterSource: changed field names for consistency and added descriptions of water sources 

tbl_pathogen: added "viruses" "bacteria" and "protozoa" since this is the level that selections are made
all other pathogens were removed from this table for this level assessment
I saved original table: "Copy Of tbl_pathogen"

tbl_doseResponse: added viruses (rotavirus) bacteria (campy) protozoa (crypto) 
Note: need to check which one was chosen by Michael since there are multiple D-R for some organisms

tbl_health: changed to viruses (rotavirus) bacteria (campy) protozoa (crypto)

Note: Why is tbl_pathogen:tbl_doseResponse a one to many? each pathogenID has a single dose response. So these don't need to be in separate tables
Note: Log removal is now based on pathogen type, however it should be per pathogen (adenovirus different from enterovirus etc. althogh some will be the same due to lack of detail)
Note: the front end selects data from databases based on user selection. It then combines all relevant information from databases in csv files for the R-tool. For the front end it keeps other data to store the scenario and later on make graphs etc.

tbl_exposure changed name to "tbl_ingestion" since exposure is generally used for the pathogens and we want to show that exposure as output. e.g. WHO QMRAdoc "magnitude and frequency of exposure to reference pathogens via the defined exposure pathways and hazardous
events" although the term isn't used consistently (e.g. Table A5.4)

Michael: the .csv file "exposure" is very different from "tbl_exposure". Please clarify what should be sent from the front end to the R-tool:
- is the number of events per year a value or a distribution?
- is the volume per event a value or a distribution?
- where do we set the number of repetitions (Monte Carlo simulation)?


Note that we allow only one intended use, for other applications the user needs to do a separate run of the model


# v0.4

Based on v0.3

Added new parameter "...Description" in the following tables:
- tbl_waterSource
- tbl_pathogen
- tbl_pathogenGroup
- tbl_exposure 
- tbl_guideline
- tbl_treatment


Updated DB structure overview with new parameter


# v0.3

Status after internal QA with DB expert Hauke:
- Improved naming of tables and columns
- Added referential integrety for table connections
- Updated DB structure 
- Updated UI flowchart ("/ui-workflow") and added relevant 
ACCESS table names for each step

# v0.2

Based on v0.1
- modified "tbl_inflow" with R script "db-scheme-for-kwb-qmra.v0.2.R"
- slightly modified MS ACCESS tables manually (e.g. defining "key" columns)

# v0.1

MS Access database "qrma-db.accdb" generated with R script "db-initialGeneration.R"
containing first draft of MS ACCESS database and R script using data from Old Ford 
Public Irrigation scenario for generating and exporting the tables to ACCESS

All tables/queries in DB are exported with R script "db-export.R" as .csv files 
into subfolder "qmra-db_accdb"
