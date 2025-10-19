#!/bin/bash
#PBS -l walltime=120:00:00
#PBS -e errorfile.err
#PBS -o logfile.log
#PBS -l select=2:ncpus=40:mem=128gb
#PBS -l place=excl
#PBS -l pvmem=200gb

tpdir=`echo $PBS_JOBID | cut -f 1 -d .`
tempdir=$HOME/scratch/job$tpdir
mkdir -p $tempdir
cd $tempdir
cp -R $PBS_O_WORKDIR/* .

module load matlab2023a
matlab -nodisplay -nosplash -nodesktop -logfile matlab_debug_log.txt < main_code.m > output_face.txt

mv ../job$tpdir $PBS_O_WORKDIR/.

