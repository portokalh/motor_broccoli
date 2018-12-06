%intersect jac clusters with labels and paths

%define paths and files
addpath('/Users/alex/Documents/MATLAB/alex/NIfTI_20140122/');
ants_path='/Users/alex/AlexBadea_MyScripts/ANTs082016/';
exvivolabels='/Users/alex/brain_data/motor/revision102318/fixed/median_images/MDT_chass_symmetric3_labels.nii.gz';
invivlabels='/Users/alex/brain_data/motor/revision102318/live/BJ_Alex_exchange/median_images/MDT_chass_symmetric3_labels.nii.gz';
clusfix='/Users/alex/brain_data/motor/revision102318/parametric_jac_ARS/FDRcorr_JACfix_binclus_ARS.nii'
pathpath='/Users/alex/brain_data/motor/revision102318/paths2MDT/'
refniifile='/Users/alex/brain_data/motor/revision102318/fixed/median_images/MDT_chass_symmetric3_labels.nii.gz'
path_label_interact='/Users/alex/brain_data/motor/revision102318/parametric_jac_ARS/labelsintersect/'
path_trk_interact='/Users/alex/brain_data/motor/revision102318/parametric_jac_ARS/trkintersect/'
pathout='/Users/alex/brain_data/motor/revision102318/parametric_jac_ARS/output/'
%read file names from directory
trkname='paths_019_M1_L_ALS_2MDTexvivo.nii.gz'
myroot=strsplit(trkname,'_ALS_2MDTexvivo.nii.gz');
prefix=char(myroot{1});
mytrkfile=[pathpath trkname];



%ex vivo processing is the focus for now

%size of cluster surviving FDR
clusfixnii=load_nii(clusfix)
clusvolvox=numel(find(clusfixnii.img)); %volume of cluster


%intersect MDT CHASS3 labels with cluster
    intersect_fix=[ants_path 'ImageMath 3 ' path_label_interact prefix '_labels_by_clus.nii.gz  m ' clusfix ' ' exvivolabels]
    system(intersect_fix,'-echo');
    myfixnii=load_nii([path_label_interact prefix '_labels_by_clus.nii.gz'])
    myfixregions=unique(myfixnii.img);
    s=size(myfixnii.img);
    res=reshape(myfixnii.img,s(1)*s(2)*s(3),1);
    [countfix,centersfix]=hist(res,myfixregions);
    
%find which labels from ou atlas did we fall upon ; how much do our clusters cover these labels   
    [data,myabbrev] = xlsread('/Users/alex/AlexBadea_MyPapers/motor_learning/PLOSONE/revision/CHASS_Annotated.xlsx','B2:B333');
    [data,controlvol_vox] = xlsread('/Users/alex/AlexBadea_MyPapers/motor_learning/PLOSONE/revision/CHASS_Annotated.xlsx','S2:S333');
    r1=myabbrev(centersfix(2:end)); %regions with coverage from clusters from fixed data
    r2=countfix(2:end)' ; %size of cluster intersection with region
    r3=data(centersfix(2:end)) ; %size of region in voxels
    r4=100*r2./r3 ; %percentage of region volume covered by cluster
    
    myrefnii=load_nii(refniifile); %read MDT labels for this study
    s=size(myrefnii.img);
    res=reshape(myrefnii.img,s(1)*s(2)*s(3),1);
    [countref,centersref]=hist(res,myfixregions);
    r3ref=countref(2:end)' ;%size of cluster intersection with region in voxels
    r4ref=100*r2./r3ref ;
       
    %% of the tract densities
    %now we calculate how many of the voxels in M1 are part of my clusters
    %we can get an absolute number and also with reference to the 90 and 95
    %and 98 percentile 
    %save no of voxels in intersection as % of region
    %save 90 , 95, 98 percentile thresholds for trk densitites 
    numstruct=numel(centersfix)-1; 
    mystructs=centersfix(2:end);
    for j=2:numel(mystructs)
    %myexp=[num2str(centersfix(2)) '_.*_L_ALS_2MDTexvivo.nii.gz']
    %['%0' length(num2str(centersfix(36))) '3.0f']
    %find prefix automagically
    %/Users/alex/brain_data/motor/revision102318/paths2MDT/paths_019_M1_L_ALS_2MDTexvivo.nii.gz
    filetrkroot=dir(fullfile('/Users/alex/brain_data/motor/revision102318/paths2MDT/',['*' sprintf('%03.0f',centersfix(j)) '*' '_L' '*']))
    prefix=strsplit(filetrkroot.name,'_ALS_2MDTexvivo.nii.gz')
    prefix=char(prefix{1})
    
    myroottrk=[ prefix '_clus_by_trk.nii.gz']
    mytrkfile=['/Users/alex/brain_data/motor/revision102318/paths2MDT/' filetrkroot.name]
    intersect_trk=[ants_path 'ImageMath 3 ' path_trk_interact myroottrk ' m ' clusfix ' ' mytrkfile];
    system(intersect_trk,'-echo');
   
    mytrkintersectnii=load_nii([path_trk_interact myroottrk]);
    mytrkintersectM1=reshape(mytrkintersectnii.img,s(1)*s(2)*s(3),1);
    mymaxtrkdensity=max(mytrkintersectM1);
    mymediantrkdensity=median(mytrkintersectM1(find(mytrkintersectM1)))
    numvoxM1inclus=numel(find(mytrkintersectM1)); %num of cluster voxels in the M1 network
    pclusinM1=100*numvoxM1inclus/clusvolvox; %percentage of clustervoxels in M1 network
    
    
    %read full M1 path file    
    mytrknii=load_nii(mytrkfile);
    mytrkniiimg=reshape(mytrknii.img,s(1)*s(2)*s(3),1);
    numvoxM1=numel(find(mytrkniiimg)); %size of M1 network
    percentinpath=100*numvoxM1inclus/numvoxM1 ; %how much does my cluster represent as a percentage of M1 network
    maxtrkval=max(mytrkniiimg);%max trk density through M1 network
    
    tdensity=[10 20 30 40 50 60 70 80 90 95 98]
    for i=1:numel(tdensity)
        tempthresh=prctile(mytrkniiimg(find(mytrkniiimg)),tdensity(i));
        trkdthresholds(i)=tempthresh
        numvoxabovethresh(i)=numel(find(mytrkintersectM1>tempthresh));
        pvt{i}=['pt' num2str(tdensity(i))];
        vt{i}=['t' num2str(tdensity(i))];
    end
    
    %the percentage of luster voxels above tdensity percentile
    %90% of voxels in M1 are in 95% of tract density in M1 network
    pabovethresh=100*numvoxabovethresh/clusvolvox;
    TTRK(j-1,:)=    [mymaxtrkdensity   mymediantrkdensity   numvoxM1inclus   pclusinM1   numvoxM1    percentinpath maxtrkval    pabovethresh trkdthresholds];
    end
    TTRKVarNames={'mymaxtrkdensity' 'mymediantrkdensity' 'numvoxM1inclus' 'pclusinM1' 'numvoxM1' 'percentinpath' 'maxtrkval'  pvt{1:end} vt{1:end}}
    tTTRK=array2table(TTRK, 'VariableNames',TTRKVarNames);
    writetable(tTTRK,[pathout 'fix_trkbyclus.xls'])
    T=table(r1,centersfix(2:end), r2,r3ref, r4ref, 'VariableNames', {'abbrev', 'label_index','intersect', 'regionvol','percentregionref'});
    writetable(T,[pathout 'fixlabels_byclus_bytracts.xls'])
   
%in vivo

