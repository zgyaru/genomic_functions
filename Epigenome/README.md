## Epigenome

1. switch CpG sites wig file to new_wig used for deeptools
input wig format (two columns): position  value
output wig format (four columns): chr    start   end value
```
python wigToDeeptools.py input.wig output.wig
```