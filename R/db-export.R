#' Default Path to MS ACCESS Database 
#' @return path to MS ACCESS DB
#' @examples
#' default_access_db()
#' @export
default_access_db <- function() {
  
system.file("database/qmra-db.accdb", package = "qmra.db")  
  
}


#' Helper Function: Default Csv Directory
#'  
#' @param db_path path to MS Access DB (default: deufault_access_db())
#' @return csv directory but with all "." replaced with
#' with "_" (e.g. "qmra-db_accdb" instead of "qmra-db.accdb")
#' @importFrom stringr str_replace_all
#' @export
#' @examples 
#' db_path <- default_access_db()
#' default_csv_dir(db_path)
default_csv_dir <- function(db_path) {
  
stringr::str_replace_all(basename(db_path),
                         "\\.", 
                         "_")
}

#' Helper Function: Default Target Directory
#'  
#' @param db_path path to MS Access DB (default: deufault_access_db())
#' @param csv_dir csv directory (default: default_csv_dir()) 
#' @return subdirectory in MS ACCESS DB directory but with all "." replaced with
#' with "_" (e.g. "qmra-db_accdb" instead of "qmra-db.accdb")
#' @export
#' @examples 
#' db_path <- default_access_db()
#' default_target_dir(db_path)

default_target_dir <- function(db_path,
                               csv_dir = default_csv_dir(db_path)) {

  sprintf("%s/%s",
          dirname(db_path), 
          csv_dir
          )
  
}


#'  Dump MS ACCESS Database To Csv Files
#'  
#' @description for exporting tables and queries from MS ACCESS DB into 
#' .csv files (one for each table/query) into subfolder "qmra-db_accdb"
#' @param db_path path to MS Access DB (default: default_access_db())
#' @param target_dir directory. By default a new directory is created in the same 
#' directory as mdb resides in. The new directory has the same name as the 
#' database file with dots substituted with underscores (default: default_target_dir())
#' @param dbg debug information (default: TRUE)
#' @param ... additional arguments passed to kwb.db::dumpDatabase()
#' @importFrom kwb.utils safePath catAndRun
#' @importFrom kwb.db dumpDatabase
#' @export
dump_access_db <- function(db_path = default_access_db(),
                           target_dir = default_target_dir(db_path), 
                           dbg = TRUE,
                           ...) {


mdb_path <- kwb.utils::safePath(db_path)

kwb.utils::catAndRun(messageText = "Exporting MS Access Database content into .csv files",
                     expr = {
                       kwb.db::dumpDatabase(db = mdb_path, 
                                            pattern = c("^tbl|^qry"),
                                            target_dir = target_dir,
                                            ...
                                            )
                     }, 
                     dbg = dbg)
}

#'  Create Zip File with MS ACCESS Database And Exported CSV files 
#' @param db_path path to MS Access DB (default: default_access_db())
#' @param target_dir directory. By default a new zip file is created in the same 
#' directory as mdb resides in. The new directory has the same name as the 
#' database file but with file extension ".zip" (default: dirname(db_path))
#' @param dbg debug information (default: TRUE)
#' @importFrom fs dir_ls
#' @importFrom zip zip
#' @importFrom withr with_dir
#' @export

create_zipfile <- function(db_path,
                           target_dir = dirname(db_path),
                           dbg = TRUE) {
  

  dump_access_db(db_path, dbg = dbg)  
  
  source_dir <- dirname(db_path)
  
  zip_file <-  sprintf("%s.zip", basename(fs::path_ext_remove(db_path)))
  
  zip_path <- file.path(target_dir, zip_file)
  
  kwb.utils::catAndRun(messageText = sprintf("Creating zipfile '%s'", zip_path), 
                       expr = {
                         withr::with_dir(new = source_dir,
                                         code = {
                                           csv_paths <- fs::dir_ls(default_csv_dir(db_path),
                                                                   recursive = TRUE,
                                                                   type = "file",
                                                                   regexp = "[.]csv$")
                                           zip::zip(zipfile = zip_path,
                                                    files = c(basename(db_path),
                                                              csv_paths))
                                           }
                                         )},
                         dbg = dbg)
  
                         
      normalizePath(zip_path)
} 
