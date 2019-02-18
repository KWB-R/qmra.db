#' Default Path to MS ACCESS Database 
#' @return path to MS ACCESS DB
#' @examples
#' default_access_db()
#' @export
default_access_db <- function() {
  
system.file("qmra-db.accdb", package = "qmra.db")  
  
}

#'  Dump MS ACCESS Database To CSV
#'  
#' @description for exporting tables and queries from MS ACCESS DB into 
#' .csv files (one for each table/query) into subfolder "qmra-db_accdb"
#' @param db_path path to MS Access DB (default: deufault_access_db())
#' @importFrom kwb.utils safePath 
#' @importFrom kwb.db dumpDatabase
#' @export
dump_access_db <- function(db_path = default_access_db()) {

mdb_path <- kwb.utils::safePath(db_path)

kwb.db::dumpDatabase(mdb = mdb_path, ptrn = c("^tbl|^qry"))
}