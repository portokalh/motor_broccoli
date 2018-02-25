%smooth jacs

addpath('/Volumes/CivmUsers/omega/Documents/MATLAB/alex/fdr_bh/fdr_bh.m') 
 addpath('/Volumes/CivmUsers/omega/Documents/MATLAB/alex/fdr_bh/')
 addpath('/Users/alex/Documents/MATLAB/fdr_bh/') 
 addpath('/Users/alex/obrien/mscripts/cvn/');
 
%where the label files are as nii.gz 
mypath='/Volumes/cretespace/alex/agoston_spm/bj/labels/newlabels/'; %'/Volumes/cretespace/alex/agoston_spm/bj/labels/rat/'; %'/Volumes/cretespace/cvnlive/VBM/'; %'/Volumes/cretespace/alex/obrien/exvivo/june15/';
path_in=mypath;
path_out='/Volumes/cretespace/alex/agoston_spm/bj/labels/newlabels/statsin/'; %'/Volumes/cretespace/alex/agoston_spm/bj/labels/statsin/';
im_path='/Volumes/cretespace/alex/agoston_spm/bj/labels/newimages/'; %'/Volumes/cretespace/alex/agoston_spm/bj/labels/images/';
prefix={'fa' 'e1' 'e2' 'rd' 'adc' 'dwi'}

runnos=dir(fullfile(path_in, '*.nii.gz'))


for i=1:numel(runnos)


runno=runnos(i).name; %controls are written first
    %path_in_labels_stats=[path_in];
    
    
    [matchstart,matchend,tokenindices,matchstring,tokenstring, tokenname,splitstring] = regexp(runno, '.nii.gz');
    root=splitstring{1};
    
    [matchstart,matchend,tokenindices,matchstring,tokenstring, tokenname,splitstring] = regexp(root, 'fa_labels_warp_');
    root1=splitstring{2};
    
    
    
   lfile=[mypath root '.nii.gz'];
   fafile=[im_path root1 '_fa.nii.gz'];
   adcfile=[im_path root1 '_adc.nii.gz'];
   e1file=[im_path root1 '_e1.nii.gz'];
   e2file=[im_path root1 '_e2.nii.gz'];
   rdfile=[im_path root1 '_rd.nii.gz'];
   dwifile=[im_path root1 '_dwi.nii.gz'];
   
    myname=root;
    mystatsfile=[path_out root '.txt']

     write_corrected_stats({lfile dwifile fafile e1file e2file rdfile adcfile},'temp.nii',mystatsfile,'RAT')

% T.Var2=volume
% T.Var3=DWI
% T.Var5=FA
% T.Var6=E1
% T.Var7=E2
% T.Var8=E3
% T.Var9=RD
% T.Var10=ADC
    
    end




