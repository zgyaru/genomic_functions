library(minfi)
library(IlluminaHumanMethylation450kanno.ilmn12.hg19)

args = commandArgs(T)
input_file = args[1]
output_file = args[2]

rgSet = read.metharray.exp(input_file)

######################################################
################# quality control ####################
######################################################
detP = detectionP(rgSet)
keep = colMeans(detP)<0.01
rgSet = rgSet[,keep]

######################################################
################ Normalization #######################
######################################################
mSetSq = preprocessQuantile(rgSet)

######################################################
## remove probes with delete detectio pvalue > 0.01 ##
######################################################
keep = rowSums(detP < 0.01) == ncol(mSetSq) 
mSetSqFlt = mSetSq[keep,]

#####################################################
##### remove probes from chromosomes X and Y ########
#####################################################
ann450k = getAnnotation(IlluminaHumanMethylation450kanno.ilmn12.hg19)
keep = !(featureNames(mSetSqFlt) %in% ann450k$Name[ann450k$chr %in% c("chrX","chrY")])
mSetSqFlt = mSetSqFlt[keep,]

#####################################################
##### removed probes associated with SNPs ###########
#####################################################
mSetSqFlt = dropLociWithSnps(mSetSqFlt, snps = c("CpG", "SBE"))

#####################################################
###### remove probes known to be cross-reactive #####
#####################################################
xReactiveProbes = read.csv('../annotation/48639-non-specific-probes-Illumina450k.csv', stringsAsFactors=FALSE)
keep = !(featureNames(mSetSqFlt) %in% xReactiveProbes$TargetID)
mSetSqFlt = mSetSqFlt[keep,]

bVals = getBeta(mSetSqFlt)
write.csv(bVals,output_file)
