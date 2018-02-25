#!/bin/bash
export PATH=$PATH://Users/alex/BROCCOLI-master/compiled/Bash/Mac/Release;
export BROCCOLI_DIR=/Users/alex/BROCCOLI-master/;
/Users/alex/BROCCOLI-master/compiled/Bash/Mac/Release/RandomiseGroupLevel /Users/alex/brain_data/motor4fsl/myinteract_jac4d.nii.gz -design bjac.mat -contrasts bjac.con -permutations 5000 -cdt 1.71 -inferencemode 2 -platform 0 -device 1 -mask MDT_mask_e3.nii.gz -output JACINTERACTcorr;
fslsplit JACINTERACTcorr_perm_tvalues.nii JACINTERACTcorr_perm_tsplit -t;
fslsplit JACINTERACTcorr_perm_pvalues.nii JACINTERACTcorr_perm_psplit -t;
fslmaths JACINTERACTcorr_perm_psplit0000.nii.gz -thr 0.94 -bin tmpthresh.nii.gz;
fslmaths tmpthresh.nii.gz -mul JACINTERACTcorr_perm_tsplit0000.nii.gz JACINTERACTcorr_perm_tvalues1thresh0p95.nii.gz;
fslmaths JACINTERACTcorr_perm_psplit0001.nii.gz -thr 0.94 -bin tmpthresh.nii.gz;
fslmaths tmpthresh.nii.gz -mul JACINTERACTcorr_perm_tsplit0001.nii.gz JACINTERACTcorr_perm_tvalues2thresh0p95.nii.gz;
