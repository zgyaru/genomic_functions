## Epigenome

### 1. [methylation] switch CpG sites wig file to new wig used for deeptools
#### Required:
* python 3.X

#### Usage:
```
python wigToDeeptools.py input.wig output.wig
```
* input.wig: format (two columns): position  value
* output.wig: format (four columns): chr    start   end value

### 2. [450k] convert idat data to beta value
Parsing IDAT files from Illumina methylation arrays.
#### Required:
* R
* minfi
* IlluminaHumanMethylation450kanno.ilmn12.hg19

#### Usage:
```
Rscript idat2beta.R input_folder output_file
```
* input_folder: the directory including all two-color IDAT files 
* output_file: beta values for all qualified probes in 'csv' format
#### Reference:
[Louise F. P et al.](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6332695/)

### 3.[ATAC]ATAC_gene_avr_max.r
#### Required: 
* R 

#### Usage:
```
Rscript ATAC_gene_avr_max.r input_file region output_file
```
* input_file:the result provided by Chipseeker  
-- format(5 columns):"seqnames","start","V4","annotation","SYMBOL"  
-- V4 means the value of peaks  
* region:the region needed to be caculated  
-- format:"promoter","genebody"  
* output_file:average and max value of genes  

