antspath='/Users/alex/ANTs/antsbin/bin/';
addpath('/Users/alex/Documents/MATLAB/alex/NIfTI_20140122/')
addpath('/Users/alex/Documents/MATLAB/alex/');
pathin='/Users/alex/brain_data/motor/labels_prerigid/'; % exvivolabels/';
pathout=[pathin 'GM_WM/'] ; 
flist=dir([pathin '*nii.gz']);
numfiles=size(flist);
numfiles=numfiles(1)

labelfile=fullfile(pathin,flist(1).name)
CTref_thresh0=fullfile(pathout,['t0_' flist(1).name])

%GM:1-59
%
%KellyKapowsky, with a prior anatomical constraint of cortical thickness of two millimetres and a gradient step size for optimisation of 0.02

for i=1:numfiles
   % i=1
myname=flist(i).name;
myroots=strsplit(myname,'.nii.gz');
myroots=myroots{1};
myroots2=strsplit(myroots,'fa_labels_warp_');
myroots2=myroots2{2}
myroots=regexprep(myroots, ' ',''); %'[^\d\w~!@#$%^&()_\-{}.]*'

myfilename=fullfile(pathin,[myroots, '.nii.gz']); % 

GMp_fout=fullfile([pathout,  myroots2,'GMp.nii.gz'] ) ; 
WMp_fout=fullfile([pathout, myroots2,'WMp.nii.gz'] ) ; 
GMWMfout=fullfile([pathout,  myroots2,'GM_WM.nii.gz'] ) ; 
sfile=['/glusterspace/alex/motor_cort_thick/inputs/' myroots2,'GM_WM.nii.gz']  ;
gfile=['/glusterspace/alex/motor_cort_thick/inputs/' myroots2,'GMp.nii.gz'] ;
wfile=['/glusterspace/alex/motor_cort_thick/inputs/' myroots2,'WMp.nii.gz']  ;
thickfile=['/glusterspace/alex/motor_cort_thick/thick/' myroots2,'_ct.nii.gz']  ;
%kellycmd{i}=['/cm/shared/apps/ANTS/KellyKapowski -d 3 -s ' sfile ' -g ' gfile ' -w ' wfile ' -t 2 -r 0.02 -o'  thickfile];
mynii=load_nii(myfilename);
mylabelsim=mynii.img;

myGM=mylabelsim*0.0;
myGMWM=mylabelsim*0.0;
%indGM=find((0<mylabelsim & mylabelsim< 47) | mylabelsim==49 | mylabelsim==53  | mylabelsim==49 | mylabelsim==53 | mylabelsim==55 | mylabelsim==57 | mylabelsim==58);
myGM((0<mylabelsim & mylabelsim< 47) |  mylabelsim==125 | mylabelsim==49 | mylabelsim==53  | mylabelsim==55 | mylabelsim==57 | mylabelsim==58| mylabelsim==149)=2;
myGM((1000<mylabelsim & mylabelsim< 1047) | mylabelsim==1125 | mylabelsim==1049 | mylabelsim==1053  | mylabelsim==1055 | mylabelsim==1057 | mylabelsim==1058| mylabelsim==1149)=2;
myGM(89<=mylabelsim & mylabelsim<=117 )=0;
myGM(mylabelsim==42)=2;
imagesc(myGM(:,:,60));
mynii.img=myGM/2; %probability* to denote a probability image with values in range 0 to 1
save_nii(mynii, GMp_fout);

antssmooth1=[antspath 'SmoothImage 3 ' GMp_fout ' 1 ' GMp_fout ' 0 ']; %has 2 voxel smoothing
system(antssmooth1); 

myWM=mylabelsim*0.0;
myWM(mylabelsim ~=0 & mylabelsim ~=1000 & myGM~=2)=3;
myWM(89<=mylabelsim & mylabelsim<=117 )=0;
myWM(134<=mylabelsim & mylabelsim<=147)=0;
myWM(1089<=mylabelsim & mylabelsim<=1117 )=0;
myWM(1134<=mylabelsim & mylabelsim<=1147)=0;
myWM( mylabelsim==65 | mylabelsim==71 | mylabelsim==72 | mylabelsim==77 | mylabelsim==83 |mylabelsim==89 | mylabelsim==90 | mylabelsim==142 | mylabelsim==163 )=3;
myWM( mylabelsim==1065 | mylabelsim==1071 | mylabelsim==1072 | mylabelsim==1077 | mylabelsim==1083 |mylabelsim==1089 | mylabelsim==1090 | mylabelsim==1142 |  mylabelsim==1163 )=3;


myWM(  mylabelsim==114 | mylabelsim==117 | mylabelsim==141 | mylabelsim==152 )=0;
myWM(  mylabelsim==1114 | mylabelsim==1117 | mylabelsim==1141 | mylabelsim==1152 )=0;
%myWM(  mylabelsim==89)=0 ;
myWM(  mylabelsim==106 | mylabelsim==109 | mylabelsim==111| mylabelsim==134 | mylabelsim==145 | mylabelsim==140 | mylabelsim==104 |mylabelsim==105)=3;
myWM(  mylabelsim==1106 | mylabelsim==1109 | mylabelsim==1111| mylabelsim==1134 |mylabelsim==1145 | mylabelsim==1140 | mylabelsim==1104 |mylabelsim==1105)=3;
%mylabelsim==85 | mylabelsim==91 |mylabelsim==1085 | mylabelsim==1091 |
figure(2)
imagesc(myWM(:,:,60));
mynii.img=myWM/3;%probability* to denote a probability image with values in range 0 to 1
save_nii(mynii, WMp_fout);
antssmooth1=[antspath 'SmoothImage 3 ' WMp_fout ' 1 ' WMp_fout ' 0 ']; %had 2 voxel smoothing
system(antssmooth1); 


myGMWM=myGM+myWM;
mynii.img=myGMWM;
save_nii(mynii, GMWMfout);




end


% for i=1:numelfiles
%     inputf=['/glusterspace/alex/motor_cort_thick/inputs' ]
%     kellycmd=/glusterspace/alex/motor_cort_thick/inputs
%     /cm/shared/apps/ANTS/KellyKapowski -d 3 -s /glusterspace/alex/motor_cortthick/${RUNNO}_GM_WM.nii -g /glusterspace/alex/motor_cortthick/${RUNNO}_GMs.nii.gz -w /glusterspace/alex/motor_cortthick/${RUNNO}_WMs.nii.gz -c [ 40, 0.001,10] -l 1 -m ${mval} -r ${gradval} -t 3 -o /glusterspace/alex/motor_cortthick/results/${RUNNO}_thick_m${mval}r${gradval}.nii
% end
