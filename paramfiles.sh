 #!/bin/bash

filenames=('FDRcorr_JACfix_tmaps.nii' 'FDRcorr_JACfix_binclus.nii' 'FDRcorr_JACfix_uclus.nii' 'FDRcorrJACINT_binclus.nii' 'FDRcorrJACINT_tmaps.nii' 
	'FDRcorrJACINT_uclus.nii' 'FDRcorrJACLIVE_binclus.nii' 'FDRcorrJACLIVE_tmaps.nii' 'FDRcorrJACLIVE_uclus.nii' 'uncorr_JACfix.nii' 'uncorr_JACfix_binclus.nii' 'uncorr_JACfix_uclus.nii' 'uncorrJACINT_binclus.nii' 'uncorrJACINT_tmaps.nii' 'uncorrJACINT_uclus.nii' 'uncorrJACLIVE_binclus.nii' 'uncorrJACLIVE_tmaps.nii' 'uncorrJACLIVE_uclus.nii')
filenames=('FDRcorrADC_tmaps.nii' 'FDRcorrADC_binclus.nii' 'FDRcorrADC_uclus.nii' 'FDRcorrFA_tmaps.nii' 'FDRcorrFA_binclus.nii' 'FDRcorrFA_tmaps_uclus.nii' 
	'uncorrCT_tmaps.nii' 'uncorrCT_binclus.nii' 'uncorrCT_uclus.nii' 
	'uncorrADC_tmaps.nii' 'uncorrADC_binclus.nii' 'uncorrADC_uclus.nii' 'uncorrFA_binclus.nii' 'uncorrFA_tmaps.nii' 'uncorrFA_uclus.nii' 
	'uncorrJACLIVE_binclus.nii' 'uncorrJACLIVE_tmaps.nii' 'uncorrJACLIVE_uclus.nii')

        for i in "${filenames[@]}"; do
    echo "$i"
/cm/shared/workstation_code_dev/matlab_execs/img_transform_executable/20170403_1100/run_img_transform_exe.sh /cm/shared/apps/MATLAB/R2015b/ /mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/median_images/parametric_jac/$i ALS ARS /mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/median_images/parametric_jac_ARS/
done
        