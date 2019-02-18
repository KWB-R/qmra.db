### R script for exporting tables and queries from MS ACCESS DB into 
### .csv files (one for each table/query) into subfolder 
### "qmra-db_accdb"
devtools::install_github("kwb-r/kwb.db")


mdb_path <- kwb.utils::safePath("qmra-db.accdb")

kwb.db::hsDumpMdb(mdb = mdb_path, ptrn = c("^tbl|^qry"))
