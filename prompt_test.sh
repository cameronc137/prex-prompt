#! /bin/sh
runnum=$1;
if [ -z "$runnum" ]
then
    echo "Run Number is empty";
    exit 1;
fi
#  Remove the LRB output files if they exist
shopt -s extglob
# find split file
slopefile_list=$(ls -1 ./LRBoutput/blueR$runnum*slope.root);
shopt -u extglob

for slopefile in $slopefile_list
do
    echo "deleting "  $slopefile;
    rm -f $slopefile;
done

#JAPAN First Pass
timenow=$(date +"%Y-%m%d-%H%M");

./qwparity -r $runnum -c prex_prompt.conf \
    --event 0:100000 \
    --rootfile-stem prexPrompt_pass1_ \
    --QwLog.logfile ./LogFiles/QwLog_run$runnum\_prompt_pass1_$timenow.txt ;

# cp ./japanOutput/summary_$runnum.txt \
#     ./SummaryText/summary_prompt_pass1_$runnum.txt;

#JAPAN Second Pass
timenow=$(date +"%Y-%m%d-%H%M");

./qwparity -r $runnum -c prex_prompt.conf \
    --event 0:100000 \
    --rootfile-stem prexPrompt_pass2_ \
    --QwLog.logfile ./LogFiles/QwLog_run$runnum\_prompt_pass2_$timenow.txt ;

# BeamMod Data Extraction (FIXME)
# BeamMod Instant Slope Calculation (FIXME)
# BeamMod Instant correction and summary (FIXME)

# Make Summary Plots/Text and sync to HallA onlineWeb
./summary.sh $runnum;
    
