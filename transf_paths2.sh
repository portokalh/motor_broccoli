

###paths to median with BJ
prefix=/mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/median_images/paths/
postfix=paths_019_M1_L
reference_invivo=/mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/preprocess/base_images/reference_file_c_BCS10dwi.nii.gz;
reference_exvivo=/mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/preprocess/base_images/reference_file_c_obrienex.nii.gz;
affine_exvivo=/mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/stats_by_region/labels/transforms/MDT_fa_to_chass_symmetric3_affine.mat;
affine_invivo=/mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/dwi/SyN_0p25_3_0p5_fa/faMDT_TerminalReacher_n24_i6/stats_by_region/labels/transforms/MDT_fa_to_chass_symmetric3_affine.mat;
diffeo_exvivo=/mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/stats_by_region/labels/transforms/chass_symmetric3_to_MDT_warp.nii.gz;
diffeo_invivo=/mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/dwi/SyN_0p25_3_0p5_fa/faMDT_TerminalReacher_n24_i6/stats_by_region/labels/transforms/chass_symmetric3_to_MDT_warp.nii.gz;

scp alex@serifos:/Users/alex/brain_data/motor/revision102318/fixed/median_images/$postfix.nii.gz $prefix
/cm/shared/workstation_code_dev/matlab_execs/img_transform_executable/20170403_1100/run_img_transform_exe.sh /cm/shared/apps/MATLAB/R2015b/ $prefix$postfix.nii.gz RAS ALS $prefix

antsApplyTransforms --float -v 1 -d 3 -i $prefix${postfix}_ALS.nii.gz -o $prefix${postfix}_ALS_exvivo.nii.gz -r $reference_exvivo -n NearestNeighbor -t   [$affine_exvivo,1]   $diffeo_exvivo;

ImageMath 3  $prefix${postfix}_ALS_exvivoByte.nii.gz Byte $prefix${postfix}_ALS_exvivo.nii.gz

scp /mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/median_images/paths/paths_019_M1_L_ALS_exvivoByte.nii.gz alex@serifos:///Users/alex/brain_data/motor/revision102318/fixed/median_images/

scp alex@serifos:///Users/alex/brain_data/motor/revision102318/4dnii/livenov18/RgtCinteractvals_cluscorr3330.nii /mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/median_images/paths/


scp alex@serifos:///Users/alex/brain_data/motor/revision102318/4dnii/livenov18/RgtCinteractvals_cluscorr3330.nii /mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/median_images/paths/
/cm/shared/workstation_code_dev/matlab_execs/img_transform_executable/20170403_1100/run_img_transform_exe.sh /cm/shared/apps/MATLAB/R2015b/ /mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/median_images/paths/RgtCinteractvals_cluscorr3330.nii ALS ARS /mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/median_images/paths/
scp RgtCinteractvals_cluscorr3330_ARS.nii alex@serifos:///Users/alex/brain_data/motor/revision102318/4dnii/livenov18/

ImageMath 3 paths_019_M1_L_ALS_exvivonorm.nii.gz Normalize paths_019_M1_L_ALS_exvivo.nii.gz
[abadea@civmcluster1 paths]$ scp paths_019_M1_L_ALS_exvivonorm.nii.gz alex@serifos:///Users/alex/brain_data/motor/revision102318/fixed/median_images/


procprefix=/mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/median_images/proc_paths_clusters/
mycluster=RgtCinteractvals_cluscorr3330_ARS.nii
mylabels=/mnt/abadeaqnap/clusterdata/abadea/VBM_14obrien01_chass_symmetric3_100micron-work/dwi/SyN_0p5_3_0p5_fa/faMDT_Control_n12_i6/median_images/MDT_chass_symmetric3_labels.nii.gz
mylabelintersect=

ImageMath 3  $procprefix${postfix}_FDRintersect_invivo_RgtC.nii.gz m $prefix${postfix}_ALS_exvivo.nii.gz