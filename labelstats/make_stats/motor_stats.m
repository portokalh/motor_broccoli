%smooth jacs

addpath('/Volumes/CivmUsers/omega/Documents/MATLAB/alex/fdr_bh/fdr_bh.m') 
 addpath('/Volumes/CivmUsers/omega/Documents/MATLAB/alex/fdr_bh/')
 addpath('/Users/alex/Documents/MATLAB/fdr_bh/') 
 addpath('/Users/alex/obrien/mscripts/cvn/');
 
 
mypath='/Users/alex/obrien/labels/exvivo/dti148lr/labels/'; %'/Volumes/cretespace/cvnlive/VBM/'; %'/Volumes/cretespace/alex/obrien/exvivo/june15/';
path_in=mypath;
path_out='/Users/alex/obrien/labels/exvivo/dti148lr/stats/';
im_path='/Users/alex/obrien/labels/exvivo/dti148lr/images/';
prefix={'fa' 'adc' 'dwi'}

runnos=dir(fullfile(path_in, '*.nii.gz'))


for i=2:numel(runnos)


runno=runnos(i).name; %controls are written first
    %path_in_labels_stats=[path_in];
    
    
    [matchstart,matchend,tokenindices,matchstring,tokenstring, tokenname,splitstring] = regexp(runno, '.nii.gz');
    root=splitstring{1};
    
    [matchstart,matchend,tokenindices,matchstring,tokenstring, tokenname,splitstring] = regexp(root, 'fa_labels_warp_');
    root1=splitstring{2};
    
    
    
   lfile=[mypath root '.nii.gz'];
   fafile=[im_path root1 '_fa.nii'];
   adcfile=[im_path root1 '_adc.nii'];
   
    myname=root;
    mystatsfile=[path_out root '.txt']

     write_corrected_stats({lfile fafile adcfile},'temp.nii',mystatsfile,'CHASS')


    
    end




