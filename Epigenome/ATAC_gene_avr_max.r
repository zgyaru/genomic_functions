library(dplyr)
library(stringr)

args = commandArgs(T)
input_file = args[1]
region = args[2]
output_file = args[3]

input_file = "AMD_Retina_peak.txt"
region = "genebody"
output_file = "test.txt"

#Chipseeker result must include "seqnames","start","V4","annotation","SYMBOL"
peak_file = read.table(input_file,header=T,na.strings = c("NA"),sep = "\t",fill = TRUE,quote = "")
temp1 = subset(peak_file,select=c(seqnames,start,end,V4,annotation,SYMBOL))
if(region=="genebody"){
  #gene region
  anno = temp1$annotation
  anno = as.character(anno)
  anno_filter = grep(pattern = "Promoter \\(1-2kb\\)|Promoter \\(<=1kb\\)|Intron*|Exon*|
            |5' UTR|3' UTR|Downstream \\(1-2kb\\)|Downstr eam \\(<1kb\\)",anno,value=FALSE)
  temp2 = temp1[anno_filter,]
  
  temp3 = aggregate(temp2$V4,list(temp2$SYMBOL),mean)
  temp4 = aggregate(temp2$V4,list(temp2$SYMBOL),max)
  colnames(temp3) <- c("Symbols","avr")
  temp3$max = temp4$x
  gene_avr_max = temp3
  write.table(gene_avr_max, file = output_file,sep = '\t', quote = FALSE, row.names = FALSE)
}else if(region=="promoter"){
  #promoter region
  anno = temp1$annotation
  anno = as.character(anno)
  anno_filter = grep(pattern = "Promoter \\(1-2kb\\)|Promoter \\(<=1kb\\)",anno,value=FALSE)
  temp2 = temp1[anno_filter,]
  
  temp3 = aggregate(temp2$V4,list(temp2$SYMBOL),mean)
  temp4 = aggregate(temp2$V4,list(temp2$SYMBOL),max)
  colnames(temp3) <- c("Symbols","avr")
  temp3$max = temp4$x
  promoter_avr_max = temp3
  write.table(promoter_avr_max, file = output_file,sep = '\t', quote = FALSE, row.names = FALSE)
}else{
  print("Please select 'genebody' or 'promoter' in region")
}


  