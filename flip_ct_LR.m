%flipLR all reachers
pathin='/Users/alex/brain_data/motor/25october2016/ct/motor_cort_thick20dec16/ct4fsl_s2/'; %'/Users/alex/brain_data/motor/27july2016/cort_thick/cortthick_exvivo'; % '/Volumes/cretespace/OBrien/18dec2014/HopkinsExVivoMouse/nii_jan9/'
list=dir (fullfile(pathin,'*stat*.nii.gz')); % dir('/Volumes/cretespace/OBrien/18dec2014/HopkinsExVivoMouse/nii_jan9/reacher*');
list=dir (fullfile(pathin,'*p0p05*.nii.gz'));
%addpath('/Volumes/workstation_home/software_SVN/shared/mathworks/NIfTI_20140122/');

for i=1:numel(list)
    brains=list(i);
    name_riginal=brains.name;
    file_in=[pathin,brains.name]
    name_parts=strsplit(name_riginal,'ctfix')
    name_out=['LRctfix',name_parts{2}]
    fileLR=[pathin,name_out];
    nii3=load_nii(file_in)
    vol3=nii3.img;
    vol3=flipdim(vol3,2);
    nii3.img=vol3;
    save_nii(nii3,fileLR);
end