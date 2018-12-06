#!/bin/bash
prefix=/mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/median_images/;
pathin=$prefix/paths_vol_norm/
pathout=$prefix/paths_vol_norm_2MDT/
echo $pathin

for entry in `ls $pathin`; do
    #echo $entry
    #echo $entry | cut -d ".nii.gz" -f 1
entry2=$entry | cut -d "." -f 1
echo $entry2
done

for entry in `ls $pathin`; do
postfix=$(echo $entry | cut -d "." -f 1)
echo $postfix
/cm/shared/workstation_code_dev/matlab_execs/img_transform_executable/20170403_1100/run_img_transform_exe.sh /cm/shared/apps/MATLAB/R2015b/ $pathin$postfix.nii.gz RAS ALS $pathout
antsApplyTransforms --float -v 1 -d 3 -i $pathout${postfix}_ALS.nii.gz -o $pathout${postfix}_ALS_2MDTexvivo.nii.gz -r $reference_exvivo -n NearestNeighbor -t   [$affine_exvivo,1]   $diffeo_exvivo;

done


#postfix=paths_019_M1_L
reference_invivo=/mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/preprocess/base_images/reference_file_c_BCS10dwi.nii.gz;
reference_exvivo=/mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/preprocess/base_images/reference_file_c_obrienex.nii.gz;
affine_exvivo=/mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/stats_by_region/labels/transforms/MDT_fa_to_chass_symmetric3_affine.mat;
affine_invivo=/mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/dwi/SyN_0p25_3_0p5_fa/faMDT_TerminalReacher_n24_i6/stats_by_region/labels/transforms/MDT_fa_to_chass_symmetric3_affine.mat;
diffeo_exvivo=/mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/stats_by_region/labels/transforms/chass_symmetric3_to_MDT_warp.nii.gz;
diffeo_invivo=/mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/dwi/SyN_0p25_3_0p5_fa/faMDT_TerminalReacher_n24_i6/stats_by_region/labels/transforms/chass_symmetric3_to_MDT_warp.nii.gz;

#scp alex@serifos:/Users/alex/brain_data/motor/revision102318/fixed/median_images/$postfix.nii.gz $prefix
#/cm/shared/workstation_code_dev/matlab_execs/img_transform_executable/20170403_1100/run_img_transform_exe.sh /cm/shared/apps/MATLAB/R2015b/ $prefix$postfix.nii.gz RAS ALS $prefix

antsApplyTransforms --float -v 1 -d 3 -i $prefix${postfix}_ALS.nii.gz -o $prefix${postfix}_ALS_exvivo.nii.gz -r $reference_exvivo -n NearestNeighbor -t   [$affine_exvivo,1]   $diffeo_exvivo;

filenames=('FDRcorr_JACfix_tmaps.nii' 'FDRcorr_JACfix_binclus.nii' 'FDRcorr_JACfix_uclus.nii' 'FDRcorrJACINT_binclus.nii' 'FDRcorrJACINT_tmaps.nii' 'FDRcorrJACINT_uclus.nii' 'FDRcorrJACLIVE_binclus.nii' 'FDRcorrJACLIVE_tmaps.nii' 'FDRcorrJACLIVE_uclus.nii' 'uncorr_JACfix.nii' 'uncorr_JACfix_binclus.nii' 'uncorr_JACfix_uclus.nii' 'uncorrJACINT_binclus.nii' 'uncorrJACINT_tmaps.nii' 'uncorrJACINT_uclus.nii' 'uncorrJACLIVE_binclus.nii' 'uncorrJACLIVE_tmaps.nii' 'uncorrJACLIVE_uclus.nii')

        for i in "${filenames[@]}"; do
    echo "$i"
/cm/shared/workstation_code_dev/matlab_execs/img_transform_executable/20170403_1100/run_img_transform_exe.sh /cm/shared/apps/MATLAB/R2015b/ /mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/median_images/parametric_jac/$i ALS ARS /mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/median_images/parametric_jac_ARS/
done
        