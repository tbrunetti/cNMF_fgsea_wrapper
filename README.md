# cNMF_fgsea_wrapper
A set of wrapper functions and a run scripts for users to run fgsea on the spectra scores output by scRNA-seq cNMF; can be modified for anything that can be preranked

## Software  
All code was tested on `R v4.2.2` using the [fgsea R Bioconductor package](https://bioconductor.org/packages/release/bioc/html/fgsea.html)  v1.22.0` on Linux OS flavor `Ubuntu 20.04.5 LTS, focal`.  

* [fgsea](https://bioconductor.org/packages/release/bioc/html/fgsea.html)  

## Setup and Usage  

1.  Clone this repository:  
```
git clone https://github.com/tbrunetti/cNMF_fgsea_wrapper  
```
2.  In R, open `fgsea_cNMF_ranks_run_script.R` and at the top replace the second line with the path to where `fgsea_cNMF_ranks_funcs.R` is located on your system.  
```{r}
source("/path/to/cNMF_fgsea_wrapper/fgsea_cNMF_ranks_funcs.R")
```

3. Update the section called user supplied arguments.  Arguments you will need to supply are the following:  

seed
gmt_file_input
output_prefix
cnmf_spectra_scores_file
adjp_thresh
nes_thresh


