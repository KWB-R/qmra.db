#' Import Database Content From CSV Files
#'
#' @param csv_dir path to csv directory with database output (default: 
#'  system.file("database/qmra-db_accdb", package = "qmra.db"))
#' @return list with multiple data.frames with database content
#' @export
#' @importFrom kwb.utils resolve
#' @importFrom rlang .data
#' @importFrom dplyr arrange left_join mutate n select 
#' @importFrom readr read_csv
#' @examples
#' \dontrun{
#' db_content <- import_database_content()
#' str(db_content, 1)
#' }
import_database_content <- function(
  csv_dir = system.file("database/qmra-db_accdb", package = "qmra.db")) {
  
  paths_list <- list(
    csv_dir = system.file("database/qmra-db_accdb", package = "qmra.db"),
    dose_response = "<csv_dir>/tbl_doseResponse.csv", 
    guideline = "<csv_dir>/tbl_guideline.csv",  
    health = "<csv_dir>/tbl_health.csv", 
    inflow = "<csv_dir>/tbl_inflow.csv",
    ingestion = "<csv_dir>/tbl_ingestion.csv",
    log_removal = "<csv_dir>/tbl_logRemoval.csv", 
    pathogen = "<csv_dir>/tbl_pathogen.csv",
    pathogen_group = "<csv_dir>/tbl_pathogenGroup.csv",
    treatment = "<csv_dir>/tbl_treatment.csv",
    references = "<csv_dir>/tbl_reference.csv",
    water_source = "<csv_dir>/tbl_waterSource.csv"
  )
  
  paths <- kwb.utils::resolve(paths_list)
  
  
  dose_response <- readr::read_csv(file = paths$dose_response)
  guideline <- readr::read_csv(file = paths$guideline)
  health <- readr::read_csv(file = paths$health)
  inflow <- readr::read_csv(file = paths$inflow)
  ingestion <- readr::read_csv(file = paths$ingestion)
  log_removal <- readr::read_csv(file = paths$log_removal)
  pathogen <- readr::read_csv(file = paths$pathogen)
  pathogen_group <- readr::read_csv(file = paths$pathogen_group)
  treatment <- readr::read_csv(file = paths$treatment)
  references <- readr::read_csv(file = paths$references)
  water_source <- readr::read_csv(file = paths$water_source)
  
  references <-   references %>% 
    dplyr::mutate(ReferenceName = sprintf("[%s](%s)", 
                                          .data$ReferenceName, 
                                          .data$ReferenceLink)) %>% 
    dplyr::select(.data$ReferenceID, .data$ReferenceName)
  
  
  dose_response_metadata <- dose_response %>% 
    dplyr::left_join(pathogen) %>% 
    dplyr::left_join(pathogen_group) %>% 
    dplyr::left_join(references) %>% 
    dplyr::arrange(.data$PathogenGroup, 
                   .data$PathogenName, 
                   .data$ReferenceName) %>% 
    dplyr::mutate(row_id = 1:dplyr::n())
  
  guideline_metadata <- guideline %>% 
    dplyr::left_join(references) %>% 
    dplyr::arrange(.data$GuidelineName, 
                   .data$ReferenceName) %>% 
    dplyr::mutate(row_id = 1:dplyr::n())
  
  health_metadata <- health %>% 
    dplyr::left_join(pathogen) %>% 
    dplyr::left_join(pathogen_group) %>% 
    dplyr::left_join(references) %>% 
    dplyr::arrange(.data$PathogenGroup, 
                   .data$PathogenName, 
                   .data$ReferenceName) %>% 
    dplyr::mutate(row_id = 1:dplyr::n())
  
  
  inflow_metadata <- inflow %>% 
    dplyr::left_join(pathogen) %>% 
    dplyr::left_join(pathogen_group) %>% 
    dplyr::left_join(water_source) %>% 
    dplyr::left_join(references) %>% 
    dplyr::arrange(.data$WaterSourceName, 
                   .data$PathogenGroup, 
                   .data$PathogenName, 
                   .data$ReferenceName) %>% 
    dplyr::mutate(row_id = 1:dplyr::n())
  
  ingestion_metadata <- ingestion %>% 
    dplyr::left_join(references) %>% 
    dplyr::arrange(.data$WaterUseName, 
                   .data$ReferenceName, 
                   .data$ReferenceName) %>% 
    dplyr::mutate(row_id = 1:dplyr::n())
  
  treatment_metadata <- treatment %>% 
    dplyr::left_join(log_removal) %>% 
    dplyr::left_join(pathogen_group) %>% 
    dplyr::left_join(references) %>%
    dplyr::arrange(.data$TreatmentName,
                   .data$PathogenGroup, 
                   .data$ReferenceName) %>% 
    dplyr::mutate(row_id = 1:dplyr::n())
  
  list(dose_response = dose_response_metadata, 
       guideline = guideline_metadata,
       health = health_metadata, 
       inflow = inflow_metadata, 
       ingestion = ingestion_metadata,
       pathogen_group = pathogen_group %>%  
         dplyr::arrange(.data$PathogenGroup),
       treatment = treatment_metadata,
       water_source = water_source %>% 
         dplyr::arrange(.data$WaterSourceName))
}
