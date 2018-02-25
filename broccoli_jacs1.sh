#!/bin/bash
export PATH=$PATH://Users/alex/BROCCOLI-master/compiled/Bash/Mac/Release;
export BROCCOLI_DIR=/Users/alex/BROCCOLI-master/;
/Users/alex/BROCCOLI-master/compiled/Bash/Mac/Release/RandomiseGroupLevel /Users/alex/brain_data/motor/25october2016/4dnii_s1/jac4d.nii.gz -design bjac.mat -contrasts bjac.con -permutations 5000 -cdt 1.71 -inferencemode 2 -platform 0 -device 1 -mask MDT_mask_e3.nii.gz -output jacfixs1corr -writepermutations myperms;
fslsplit jacfixs1corr_perm_tvalues.nii jacfixs1corr_perm_tsplit -t;
fslsplit jacfixs1corr_perm_pvalues.nii jacfixs1corr_perm_psplit -t;
fslmaths jacfixs1corr_perm_psplit0000.nii.gz -thr 0.95 -bin tmpthresh.nii.gz;
fslmaths tmpthresh.nii.gz -mul jacfixs1corr_perm_tsplit0000.nii.gz jacfixs1corr_perm_tvalues1thresh0p95.nii.gz;
fslmaths jacfixs1corr_perm_psplit0001.nii.gz -thr 0.95 -bin tmpthresh.nii.gz;
fslmaths tmpthresh.nii.gz -mul jacfixs1corr_perm_tsplit0001.nii.gz jacfixs1corr_perm_tvalues2thresh0p95.nii.gz;
