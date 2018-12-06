#!/bin/bash

filenames=('FDRcorr_JACfix_binclus.nii', 'FDRcorr_JACfix_uclus.nii','FDRcorrJACINT_binclus.nii','FDRcorrJACINT_tmaps.nii','FDRcorrJACINT_uclus.nii', 'FDRcorrJACLIVE_binclus.nii', 'FDRcorrJACLIVE_tmaps.nii', 'FDRcorrJACLIVE_uclus.nii', 'uncorr_JACfix.nii', 'uncorr_JACfix_binclus.nii', 'uncorr_JACfix_uclus.nii', 'uncorrJACINT_binclus.nii', 'uncorrJACINT_tmaps.nii','uncorrJACINT_uclus.nii','uncorrJACLIVE_binclus.nii', 'uncorrJACLIVE_tmaps.nii', 'uncorrJACLIVE_uclus.nii')

        for i in "${filenames[@]}"; do
    echo "$i"
done
        