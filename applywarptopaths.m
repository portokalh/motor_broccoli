%# The following cluster command converts ${input_file} from ARI to ALS and will put it in the ${output_folder} with '_ALS' appended to filename, i.e. ...fa_ALS.nii.gz, etc.
myfile='/mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/dwi/'
ImageMath 3 /mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/dwi/paths4motor90.nii.gz ThresholdAtMean /mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/dwi/paths4motor.nii.gz 0.9
/cm/shared/workstation_code_dev/matlab_execs/img_transform_executable/20170403_1100/run_img_transform_exe.sh /cm/shared/apps/MATLAB/R2015b/ /mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/dwi/paths4motor90.nii.gz RAS ALS /mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/dwi/  
antsApplyTransforms --float -v 1 -d 3 -o /mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/dwi/SyN_0p25_3_0p5_fa/faMDT_TerminalReacher_n24_i6/median_images/paths4motor90.nii.gz -i /mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/dwi/paths4motor90_ALS.nii.gz -r /mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/preprocess/base_images/reference_file_c_BCS10dwi.nii.gz -n NearestNeighbor -t   [/mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/dwi/SyN_0p25_3_0p5_fa/faMDT_TerminalReacher_n24_i6/stats_by_region/labels/transforms/MDT_fa_to_chass_symmetric3_affine.mat,1]  /mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/dwi/SyN_0p25_3_0p5_fa/faMDT_TerminalReacher_n24_i6/stats_by_region/labels/transforms/chass_symmetric3_to_MDT_warp.nii.gz ;


%make a copy of the headfile , change params to heart's desire
%%SAMBA_startup /mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-results/VBM_18abb05_chass_symmetric3.headfile
% % %#cat /mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/dwi/SyN_0p25_3_0p5_fa/faMDT_TerminalReacher_n24_i6/reg_images/
% % cd /mnt/abadeaqnap/clusterdata/abadea/VBM_18abb05_chass_symmetric3-work/dwi/SyN_0p25_3_0p5_fa/faMDT_TerminalReacher_n24_i6/median_images/sbatch/
% % cat 8397467_create_chass_symmetric3_labels_for_MDT.bash
% % /cm/shared/workstation_code_dev/matlab_execs/img_transform_executable/20170403_1100/run_img_transform_exe.sh /cm/shared/apps/MATLAB/R2015b/ ${input_file} ARI ALS ${output_folder}