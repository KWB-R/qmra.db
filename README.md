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
