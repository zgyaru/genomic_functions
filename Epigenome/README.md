## Epigenome

### 1. [methylation] switch CpG sites wig file to new wig used for deeptools

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
