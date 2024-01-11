library(fgsea)
source("/path/to/fgsea_cNMF_ranks_funcs.R") # be sure to update the path to reflect where this file is located on your system

##########################################################################################
################################## REQUIRED USER INPUTS ##################################
##########################################################################################
seed = 42
gmt_file_input = "/path/to/gmt/file/example.gmt" # you can use any gmt file, all msigdb gmts are the ones tested
output_prefix = "/path/to/output/and/file/prefix/fgsea_for_cNMF_spectra_scores_01102024" # path and prefix of what to call saved file
cnmf_spectra_scores_file = "/path/to/cNMF_spectra_file/d4_cNMF.gene_spectra_score.k_5.dt_0_02.txt" # path to cNMF output spectra scores
adjp_thresh = 0.05 # non-inclusive, anything below this value will be retained
nes_thresh = "positive" # options are positive, negative, or both
##########################################################################################
##########################################################################################



##########################################################################################
################## Step 1 - calculate your enrichment scores using fgsea #################
### ONLY NEEDS TO BE DONE ONCE FOR A DATASET, as data is save as .Rdat for use later! ####
##########################################################################################
step1_enrichment_results <- calculate_enrichment(gmt_file_input = gmt_file_input, 
                                                 output_prefix = output_prefix, 
                                                 cnmf_spectra_scores_file = cnmf_spectra_scores_file, 
                                                 seed = seed)

##########################################################################################
###################### Step 2 - filter fGSEA results by padj and NES #####################
##########################################################################################
filtered_fgsea_results <- filter_results(unfiltered_fgsea_results = step1_enrichment_results@unfiltered, 
                                         adjp_thresh = adjp_thresh, 
                                         nes_thresh = nes_thresh)

# if you want to look at your results as a dataframe, you can just put your GEP id in the key
# for example, if you wanted to store the GEP1 results as a dataframe you could run the following:
myGep1_results <- filtered_fgsea_results[["1"]]


##########################################################################################
###################### Step 3 - visualization and leading edge genes #####################
##########################################################################################
# plot the top 10 NES pathways on your filtered data for GEP 1
table_summary_plot(filtered_results = filtered_fgsea_results, 
                   gmt_large_list = step1_enrichment_results@gmt_large_list, 
                   input_gsea_datasets = step1_enrichment_results@input_gsea_datasets, 
                   gep_id = "1")

# you can also provide a list of pathways you want to plot
table_summary_plot(filtered_results = filtered_fgsea_results, 
                   gmt_large_list = step1_enrichment_results@gmt_large_list, 
                   input_gsea_datasets = step1_enrichment_results@input_gsea_datasets, 
                   gep_id = "1",
                   pathway_names = c("HALLMARK_DNA_REPAIR", "HALLMARK_UNFOLDED_PROTEIN_RESPONSE"))

# you can pick a single pathway to get a true GSEA plot
traditional_gsea_plot(gmt_large_list = step1_enrichment_results@gmt_large_list, 
                      input_gsea_datasets = step1_enrichment_results@input_gsea_datasets, 
                      gep_id = "1", 
                      pathway_name = "HALLMARK_DNA_REPAIR")


# you can pick a single pathway and get the genes that are contributing the most to your enrichment score (leading edge -- defined as
# all of the genes whose rank is more extreme than the maximum deviation of the enrichment score from zero)
get_leading_edge(filtered_results = filtered_fgsea_results, gep_id = "1", pathway_name = "HALLMARK_UNFOLDED_PROTEIN_RESPONSE")
