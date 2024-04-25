#### Import transformed data ####
mydata_trans <- read_csv("./transformed_data/transformed_data.csv")

#### Clustering and Phenograph ####
cols <- colnames(mydata_trans)[-grep('FSC|SSC|Time|optsne|graph|pca|conditio|replica|SevenAAD|CD45', colnames(mydata_trans))]
mydata_trans_clustering <- mydata_trans %>%
  select(all_of(cols))

mydata_trans_clustering <- as.matrix(mydata_trans_clustering)
set.seed(124678)
clustering_results <- FastPG::fastCluster(mydata_trans_clustering,k=50,distance='euclidean',ef_construction = 1000,num_threads = 4)

mydata_trans["cluster"] <- clustering_results$communities

plot <- mydata_trans %>%
  select(cols, cluster) %>%
  group_by(cluster) %>%
  summarise_all(median) %>%
  remove_rownames() %>%
  column_to_rownames('cluster') %>% 
  as.matrix() %>% 
  pheatmap:::scale_rows() %>% 
  Heatmap(rect_gp = gpar(col = "white", lwd = 2),
          column_names_rot = 45, show_heatmap_legend = T,
          row_names_side = 'left', heatmap_legend_param = list(title = 'Z-score'),
          col = circlize::colorRamp2(seq(min(.), max(.), length = 3), c('#4575B4', 'white', '#D73027')))

plot

cluster_order <- grid::grid.get(grep('text', grid::grid.ls(print = FALSE)[1]$name, 
                    value = TRUE)[1])[[1]]

#### Enrichment analysis ####
#Study the occupancy of each cluster, and determine how it is enriched or not postSpn.
#Replicates are pooled, otherwise too few cells in control experiments.

#Function to introduce pseudo_count in control conditions

is.control <- function(.s){
  grepl("saline|preSpn",.s)
}

#First we compare saline and postSpn
occupancy <- mydata_trans %>%
  mutate(cluster=as.character(cluster)) %>% 
  group_by(condition) %>%
  mutate(n_condition=n()) %>% 
  ungroup() %>% 
  group_by(cluster,condition) %>% 
  mutate(n_cluster_condition=n()) %>%
  ungroup() %>% 
  distinct(condition,cluster,n_condition,n_cluster_condition) %>% 
  dplyr::filter(condition %in% c("postSpn","saline"))
  
occupancy_postSpn <- occupancy %>% 
  filter(condition=="postSpn") %>% 
  rename("n_postSpn"=n_condition) %>% 
  rename("n_cluster_postSpn"=n_cluster_condition) %>% 
  select(-condition)
  
occupancy_saline <- occupancy %>% 
  filter(condition=="saline") %>% 
  rename("n_saline"=n_condition) %>% 
  rename("n_cluster_saline"=n_cluster_condition) %>% 
  select(-condition)

occupancy_full <- full_join(occupancy_postSpn,occupancy_saline,by=c("cluster"))

occupancy_full <- occupancy_full %>% 
  mutate(n_postSpn=max(n_postSpn,na.rm=TRUE)+n(),
         n_saline=max(n_saline,na.rm=TRUE)+n(),
         n_cluster_postSpn=ifelse(is.na(n_cluster_postSpn),0,n_cluster_postSpn)+1,
         n_cluster_saline=ifelse(is.na(n_cluster_saline),0,n_cluster_saline)+1,
         frac_postSpn=n_cluster_postSpn/n_postSpn,
         frac_saline=n_cluster_saline/n_saline,
         enrichment=log2(frac_postSpn/(frac_saline))) 

#Let's reorder the clusters according to log-enrichment
enrichment <- occupancy_full %>% 
  arrange(cluster) %>%
  #mutate(index=row_number()-1) %>% #there is a cluster 0
  dplyr::arrange(desc(enrichment)) %>% 
  distinct(cluster, enrichment) %>%
  mutate(cluster=factor(cluster,levels=cluster))

p0 <- enrichment %>%
  select(cluster,enrichment) %>% 
  ggplot(aes(x=cluster,y=enrichment))+
  geom_col()+
  theme_cowplot()+
  coord_flip()+
  labs(xlim(c(-3,3)))+
  ylab("log-enrichment postSpn/saline")

p0
ggsave("./flow_cytometry_toolbox_R/figures/log_enrichments.pdf",width=3,height=6)

### Let's reorder enrichment with the phenograph order ###

p1 <- enrichment %>%
  select(cluster,enrichment) %>% 
  mutate(cluster=factor(cluster,levels=rev(cluster_order))) %>%
  #mutate(cluster=fct_reorder(cluster,rev(cluster_order))) %>% 
  arrange(cluster) %>% 
  ggplot(aes(x=cluster,y=enrichment))+
  geom_col()+
  theme_cowplot()+
  coord_flip()+
  labs(xlim(c(-3,3)))+
  ylab("log-enrichment postSpn/saline")

p1
ggsave("./flow_cytometry_toolbox_R/figures/log_enrichments_ordered_ph_cluster.pdf",width=3,height=6)
