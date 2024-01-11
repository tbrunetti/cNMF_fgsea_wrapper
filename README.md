# cNMF_fgsea_wrapper
A set of wrapper functions and a run scripts for users to run fgsea on the spectra scores output by scRNA-seq cNMF; can be modified for anything that can be preranked.

## Software  
All code was tested on `R v4.2.2` using the [fgsea R Bioconductor package](https://bioconductor.org/packages/release/bioc/html/fgsea.html) v1.22.0 on Linux OS flavor `Ubuntu 20.04.5 LTS, focal`.  

* [fgsea](https://bioconductor.org/packages/release/bioc/html/fgsea.html)  

## Setup and Usage  

1.  Clone this repository:  
```
git clone https://github.com/tbrunetti/cNMF_fgsea_wrapper  
```
<br/>  

2.  In R, open `fgsea_cNMF_ranks_run_script.R` and at the top replace the second line with the path to where `fgsea_cNMF_ranks_funcs.R` is located on your system.  
```{r}
source("/path/to/cNMF_fgsea_wrapper/scripts/fgsea_cNMF_ranks_funcs.R")
```
<br/>  

3. Update the section called user supplied arguments.  Arguments you will need to supply are the following:  

| user input parameters    | Description |
| :----------------------: | :---------: |
| seed                     | an integer to set the seed for fGSEA to help with data reproducibility |  
| gmt_file_input           | the full path to the file name containig the gmt file you want to use for fGSEA. Examples: [MSigDb](https://www.gsea-msigdb.org/gsea/msigdb/index.jsp) provides downloadable gmt files.  For custom made gmt files, please refer to [the Broad Institute Wiki](https://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Data_formats#GMT:_Gene_Matrix_Transposed_file_format_.28.2A.gmt.29) for how to format a gmt file.  |  
| output_prefix            | the full path and string prefix of where and the beginning file name you want the software to use to save various steps of each result so you can load the result in later without rerunning steps.  Ex: ~/k3_allGeps, would save your results in the home directory and all files would have the k3_allGeps string in the save title of the files generated. |  
| cnmf_spectra_scores_file | This is one of the output files generated from the software [cNMF](https://github.com/dylkot/cNMF).  THe file to specify here is the one that contain the spectra scores.  Ex: d4_cNMF.gene_spectra_score.k_5.dt_0_02.txt |  
| adjp_thresh              | a floating point value between the range of 0-1.  This is used in step2 of the run script and is the maximum adjusted_pvalue (non-inclusive) to retain for downstream analysis.  Ex: setting this to 0.05, would be the same as applying an adjust-pvalue < 0.05. |  
| nes_thresh               | This the the normalized enrichment score threshold, but it can only be set to one of 3 options: positive, negative, or both. For cNMF, I strongly recommend setting this to positive.  Ex: setting this to positive, would only keep results that have a positive NES, meaning the those would be the top terms/pathways/genes driving your GEP.  |  

<br/>  

## Reusing prior results  
You will notice each time you run steps 1 or 2, two files are automatically generated:  
* **<output_prefix>_unfiltered.Rdat**  (saved output of step1)
* **<output_prefix>\_filtered_padj\_<adjp_thresh>\_nes_<nes_thresh>.Rdat** (saved output of step2)
  
Since these are saved, you can skip steps 1 and 2 and always go directly to 3 without rerunning.  Additionally, if you wanted to apply different adjusted pvalue and NES filters, you can always just load in the step1 object and start at step 2. For example, if my step 1 file was named, *hallmark_gmt_unfiltered.Rdat* and my step2 file was named *hallmark_gmt_filtered_padj_0.05_nes_positive.Rdat*, I can run the following commands:
```{r}
load(hallmark_gmt_unfiltered.Rdat)
load(hallmark_gmt_filtered_padj_0.05_nes_positive.Rdat)
```
You should see both data objects reappear in your variable space in Rstudio and you can go straight to step 3.  

