### R script for generating initial MS ACCESS DB structure based on Old Ford 
### public irrigation scenario

devtools::install_github("kwb-r/kwb.qmra")
devtools::install_github("kwb-r/kwb.db")

library(dplyr)
library(kwb.qmra)

temp <- tempdir()
url <- "https://zenodo.org/record/159527/files/QMRA_OldFord.zip"
t_path <- file.path(temp, basename(url))
download.file(url, dest= t_path, mode="wb") 
unzip(t_path, exdir = temp)

scenarios_dir <- file.path(temp, "scenarios")

cat(sprintf("### Available scenarios:\n%s",
            paste(dir(scenarios_dir), collapse = "\n")))
    
    #### DEFINE DIRECTORY ################
    confDir <- dir(scenarios_dir,full.names = TRUE)[1]
    confDir
    config <- config_read(confDir)     
    

get_references <- function(df) {
  df %>% 
    dplyr::select(!!quo(ReferenceName), !!quo(ReferenceLink)) %>% 
    dplyr::filter(!is.na(!!quo(ReferenceName)))
}


config$doseresponse <- config$doseresponse %>%  
  dplyr::rename("ReferenceName" = "Reference", 
                "ReferenceLink" = "Link")

    
tbl_references <- get_references(config$inflow) %>%
    rbind(get_references(config$treatment$processes)) %>% 
    rbind(get_references(config$doseresponse )) %>%  
  rbind(get_references(config$health)) %>% 
  dplyr::group_by(ReferenceName, ReferenceLink) %>% 
  dplyr::summarise(n = n()) %>%  
  dplyr::ungroup() %>% 
  dplyr::mutate(ReferenceID = 1:n()) %>% 
  dplyr::select(ReferenceID, ReferenceName, ReferenceLink)
                  
        
tbl_pathogenGroups <- data.frame(PathogenGroup = unique(config$doseresponse$PathogenGroup), 
                         stringsAsFactors = FALSE) %>%
              dplyr::mutate(PathogenGroupID = 1:n()) %>% 
              dplyr::select(PathogenGroupID, PathogenGroup)

tbl_pathogens <- config$doseresponse[,1:3] %>% 
                 dplyr::left_join(tbl_pathogenGroups)


tbl_doseresponse <- config$doseresponse %>% 
  dplyr::left_join(tbl_references, by = c("ReferenceName", "ReferenceLink")) %>% 
  dplyr::left_join(tbl_pathogenGroups) 


tbl_health <- config$health %>% 
  dplyr::left_join(tbl_references, by = c("ReferenceName", "ReferenceLink")) %>% 
  dplyr::left_join(tbl_pathogens) %>% 
  dplyr::select(PathogenID, PathogenGroupID, ReferenceID, 
                infection_to_illness, dalys_per_case)

tbl_treatment_processes_per_patGroup_kwb <- config$treatment$processes %>% 
  dplyr::left_join(tbl_references, by = c("ReferenceName", "ReferenceLink")) %>% 
  dplyr::left_join(tbl_pathogenGroups)


tbl_watersource <- data.frame(WaterSourceID = c(1,2),
                              WaterSourceName = c("drinking water", "wastewater"), 
                              stringsAsFactors = FALSE)

tbl_processes <- tbl_treatment_processes_per_patGroup_kwb %>% 
    dplyr::group_by(TreatmentID, TreatmentName, TreatmentGroup, PathogenGroupID, 
                    PathogenGroup, ReferenceID, ReferenceName, ReferenceLink) %>% 
    dplyr::summarise(n = n()) %>% 
    dplyr::select(-n) %>% 
    dplyr::ungroup() %>%  
  dplyr::mutate(WaterSourceID = ifelse(grepl(pattern = 'WHO \\(2011\\)',
                                             ReferenceName), 
                                       1, 
                                       2)) %>% 
  dplyr::left_join(tbl_watersource)


tbl_treatment_processes <- tbl_processes %>% 
  dplyr::group_by(TreatmentID, TreatmentName, TreatmentGroup) %>% 
  dplyr::summarise(n = n()) %>% 
  dplyr::select(-n) %>%  
  dplyr::mutate(WaterSourceID = ifelse(TreatmentID < 16, 1, 2))



tbl_inflow <- config$inflow %>% 
  dplyr::group_by(PathogenGroup, simulate,  type, value,min,max, mode,  mean,
                  sd, meanlog, sdlog, ReferenceName,  ReferenceLink) %>%  
  dplyr::summarise(n = n()) %>% 
  dplyr::left_join(tbl_references, by = c("ReferenceName", "ReferenceLink")) %>% 
  dplyr::left_join(tbl_pathogenGroups) %>% 
  dplyr::select(-n) %>% 
  dplyr::ungroup() %>% 
  dplyr::mutate(WaterSourceID = 2) %>% 
  dplyr::select(PathogenGroupID, ReferenceID,  WaterSourceID, min, max)

path_db <- "C:/Users/mrustl.KWB/Documents/RProjects/kwb.qmra.accdb"

#file <- "C:/Users/mrustl.KWB/Documents/RProjects/qmra-db.RData"
#save.image(file = file)
#load(file)

table_names <- grep("^tbl", ls(), value = TRUE)

#table_names <- c("tbl_health", "tbl_inflow")

tables <- setNames(lapply(table_names, get), table_names)



for (table_name in table_names) {
  
  kwb.db::hsPutTable(
    path_db, tables[[table_name]], tbl = table_name, overwrite = TRUE
  )
}


