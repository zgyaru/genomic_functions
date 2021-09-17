import sys
import os

# switch CpG sites wig file to new_wig used for deeptools
# input CpG sites wig file and output wig file

# input wig format (two columns): position  value
# new wig format (four columns): chr    start   end value

#############################################
# for example:
# python wigToDeeptools.py input.wig output.wig


def switchWig(inFile, outFile):
    ## switch wig to deeptools format
    ## inFile:wig file
    ## outFile: wigFile for deeptools
    fw = open(outFile,'w')
    fr = open(inFile)
    lines = fr.readlines()
    for i in range(len(lines)-1):
        line_now = lines[i].strip().split('\t')
        line_pos = lines[i+1].strip().split('\t')
        if line_pos[0].find('variableStep') == 0:
            continue
        if line_now[0].find('variableStep') == 0:
            chrID = line_now[0].split('=')[1]
            if(chrID.isdigit()){
                chrID = 'chr'+chrID
            }
            #print(chrID)
        elif len(line_now) == 2:
            start = line_now[0]
            if int(line_pos[0]) - int(line_now[0]) < 400:
                end = line_pos[0]
            else:
                end = str(int(line_now[0])+400)
            fw.write(chrID+'\t'+start+'\t'+end+'\t'+line_now[1]+'\n')
    fw.flush()
    fw.close()
    
    
def parse_args():
    input_path = sys.argv[1]
    output_path = sys.argv[2]
    print("switch file: "+input_path+" to file: "+output_path)
    switchWig(input_path, output_path)
