#### Importing data with CytoExploreR and data wrangling ####
fs <- cyto_setup(data_folder_path,gatingTemplate = "./Manual-Gating.csv",markers=FALSE,details=FALSE)
#data are imported as GatinSet object (class used in flowWorkSpace)
#markers and details set to FALSE to not edit these, as we prefer to edit these using the following script

conditions <- c(simplify(lapply(c(79:84),function(.i){paste("postSpn",as.character(.i),sep="_")})),
             simplify(lapply(c(1:6),function(.i){paste("preSpn",as.character(.i),sep="_")})),
             simplify(lapply(c(67:72),function(.i){paste("saline",as.character(.i),sep="_")})))

cyto_details(fs)$conditions <- conditions
cyto_details(fs)$replica <- simplify(lapply(cyto_details(fs)$condition,function(.s){stringr::str_split(.s,pattern="_")[[1]][2]}))
cyto_details(fs)$treatment <- simplify(lapply(cyto_details(fs)$condition,function(.s){stringr::str_split(.s,pattern="_")[[1]][1]}))
replica <- cyto_details(fs)$replica

new_channels <- simplify(base::lapply(cyto_channels(fs),function(.s) str_replace_all(.s,'FJComp.','')))
#get rid of FJComp. in all channels names

channels_to_plot <- cyto_channels(fs)[1:30]
#actual channels of interests

#### Data transformation (asinh) ####

trans.obj <- function(x){asinh(x/6000)}
#defines arc sin hyperbolic transformation as a function

invtrans.obj <- function(x){sinh(x)*6000}
#define the inverse transformation

trans <- scales::trans_new("asinh_trans",trans.obj,invtrans.obj)
#define a new transformation object using scales package

transList <- transformerList(c(cyto_fluor_channels(fs)),trans)
#create a transformerList object, where to each channel is associated a transformation

fs <- cyto_transform(fs,parent="root",trans=transList,channels=cyto_fluor_channels(fs))
#transformation are applied to flow cytometry data using the transformerList object created above

#### Define inf and sup for plotting data ####
lim_inf <- c(rep(c(0),times=9),rep(-1e5,times=20))
lim_sup <- c(5e6,5e6,2e6,2e6,2e6,7e5,2e6,7e5,2e6,rep(1e6,times=20))