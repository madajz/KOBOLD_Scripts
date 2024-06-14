# KOBOLD_Scripts
Proteomics analysis scripts for KOBOLD including GSEAs

In this repo are the analysis scripts for several figures in the Nature Communications manuscript titled: A diverse proteome is present and enzymatically active in metabolite extracts. They all follow a gneral workflow similar to DEP (https://bioconductor.org/packages/devel/bioc/vignettes/DEP/inst/doc/DEP.html); in short compounds with 0 variance or too muchi missingness are removed, then there is left truncated imputation, differntial abundance analysis via limma, and finally GSEA using clusterProfiler.
