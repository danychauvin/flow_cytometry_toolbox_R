#### Setting up the environment ####
setwd("/home/dany/Documents/myvault/70-79_Travail/73_Recherche_emploi_Data_Scientist/roche_flowcytometrydataanalyst_202401/onsite_interview_preparation/skills_assessment")
data_folder_path <- './raw_data/'
set.seed(1234)
knitr::opts_chunk$set(cache=TRUE, warning=FALSE, message=FALSE, cache.lazy=FALSE)

#### DO NOT MODIFY BELOW ####
#### Loading flow cytometry packages ####
fc_packages <- c('flowCore','ggcyto','flowWorkspace','cytolib','CytoML','openCyto','CytoExploreR','flowViz')
lapply(fc_packages, library, character.only=TRUE)

#### Loading visualization packages ####
visu_packages <- c('ggrepel','ComplexHeatmap','cowplot', 'scales')
lapply(visu_packages, library, character.only=TRUE)

#### Loading other packages ####
other_packages <- c('tidyverse')
lapply(other_packages, library, character.only=TRUE)

