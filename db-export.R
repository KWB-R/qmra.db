### R script for exporting tables and queries from MS ACCESS DB into 
### .csv files (one for each table/query) into subfolder 
### "kwb_qmra_accdb"
devtools::install_github("kwb-r/kwb.db")

mdb_dir <- "C:/Users/mrustl.KWB/Desktop/QMRA_workflow/kwb.qmra-db"
mdb_version <- "v0.5"

mdb_path <- kwb.utils::safePath(sprintf(
  "%s/%s/kwb.qmra.%s.accdb", mdb_dir, mdb_version, mdb_version
))

kwb.db::hsDumpMdb(mdb = mdb_path, ptrn = c("^tbl|^qry"))
