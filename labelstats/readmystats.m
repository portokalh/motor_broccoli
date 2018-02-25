%read in stats file
 addpath('/Volumes/CivmUsers/omega/Documents/MATLAB/alex/fdr_bh/')
 addpath('/Users/alex/Documents/MATLAB/fdr_bh/') 
 addpath('/Users/alex/obrien/mscripts/cvn/');
 %/Volumes/CivmUsers/omega/Documents/MATLAB/alex/fdr_bh/
%0 CVN; 1 is CTRL


prefix='all';



%path_in='/Volumes/cretespace/alex/obrien/exvivo_3_0p5/CHASS_SYMM_regional_stats/'; %'/Users/alex/obrien/labels/exvivo/dti148lr/stats/';
path_in='/Volumes/cretespace/alex/agoston_spm/bj/labels/statsin/';

%'/Volumes/cretespace/cvn_15dec2014_corrlabels/'; %'/Volumes/mf177/cluster_test/';
path_out=[path_in 'roi_stats/'];

mkdir path_out;

runnocontrols=dir(fullfile(path_in, '/control/*.txt')) %dir(fullfile(path_in, '/control/*control*'))
runnotreated=dir(fullfile(path_in, '/treated/*.txt')) % dir(fullfile(path_in, '/reacher/*reacher*'))
rc=numel(runnocontrols);
rt=numel(runnotreated);
rall=rc+rt;

ind1=1:rc;%controls
ind2=rc+1:rall;%reachers

%runnos=dir(fullfile(path_in, '*.txt'))

% TableAlx = table(group,runnos', 'VariableNames', {'Group'  'Runno'});

% /Volumes/cretespace/alex/agoston_spm/bj/labels/statsin/treated/fa_labels_warp_S65544.txt 
for i=1:rall
if i <= rc %numel(runnocontrols)
    runno=runnocontrols(i).name; %controls are written first
    path_in1=[path_in 'control/'];
    
    %path_in_labels_stats=path_in;
else
    runno=runnotreated(i-rc).name
    path_in1=[path_in 'treated/'];
    %path_in1=path_in;
end
    mystatsfile=[path_in1 runno]
    T=0;
    T=readtable(mystatsfile,'HeaderLines',2,'Delimiter','\t');
%{file_labels_in,file_fa, file_e1,file_rd, file_e2, file_e3, file_adc,file_dwi }
  %standard order
     vol(i,:)=T.Var3; %T(:,3); %T.Var2;  
     dwi(i,:)=T.Var4; %T(:,4);% T.Var3;
     fa(i,:)=T.Var5;; %T(:,5);%T.Var4;
     e1(i,:)= T.Var6;%T(:,6);%T.Var5;
     e2(i,:)=T.Var7;; %T(:,7);%T.Var6;
%     e3(i,:)=T.Var7;% T(:,8);%T.Var7;
    rd(i,:)=T.Var8;% %T(:,9);%T.Var8;
    adc(i,:)=T.Var9;; %T(:,10);%T.Var9;
    %hess order
  %  vol(i,:)=T.Var3; % T(:,3); %
%    dwi(i,:)= T.Var4;%T(:,4);%
 %   fa(i,:)=T.Var4;%T(:,5);%
%     e1(i,:)=T.Var6;% T(:,6);%
%     e2(i,:)=T.Var7;%T(:,7);%
%     e3(i,:)=T.Var8;%T(:,8);%
%     rd(i,:)=T.Var9;%T(:,9);%
  %  adc(i,:)=T.Var5;%T(:,10);%
end
%% 

%path_out='/Volumes/cretespace/alex/cvn_corrected_labels/'

%dlmwrite([path_out,'vol.txt'], vol', 'delimiter', '\t', 'precision', '%10.8f', '-append','roffset', 1);
 
dlmwrite([path_out,'vol.txt'], vol, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
 dlmwrite([path_out,'dwi.txt'], dwi, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
dlmwrite([path_out,'fa.txt'], fa, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
 dlmwrite([path_out,'e1.txt'], e1, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
 dlmwrite([path_out,'e2.txt'], e2, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
% dlmwrite([path_out,'e3.txt'], e3, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
 dlmwrite([path_out,'rd.txt'], rd, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
dlmwrite([path_out,'adc.txt'], adc, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);

% dlmwrite([path_out,'predictors.txt'], predictors, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
% writetable(TableAlx, [path_out,'predictors_table.txt'] , 'WriteRowNames',true)




% writemystats1(dwi(ind2,2:end)',dwi(ind1,2:end)',[path_out 'cvn_stats_dwi' prefix],0)
writemystats1(fa(ind2,2:end)',fa(ind1,2:end)',[path_out 'my_stats_fa' prefix ],0)
 writemystats1(e1(ind2,2:end)',e1(ind1,2:end)',[path_out 'my_stats_e1' prefix ],0)
writemystats1(e2(ind2,2:end)',e2(ind1,2:end)',[path_out 'my_stats_e2' prefix],0)
%writemystats1(e3(ind2,2:end)',e3(ind1,2:end)',[path_out 'cvn_stats_e3' prefix],0)
 writemystats1(rd(ind2,2:end)',rd(ind1,2:end)',[path_out 'my_stats_rd' prefix ],0)
 writemystats1(adc(ind2,2:end)',adc(ind1,2:end)',[path_out 'my_stats_adc' prefix ],0)
writemystats1(vol(ind2,2:end)',vol(ind1,2:end)',[path_out 'my_stats_vol' prefix],1)

%[h1,p1,ci1,stats1] = ttest2(fa(ind2,:),fa(ind1,:));

 
% T.Var2=volume
% T.Var3=DWI
% T.Var5=FA
% T.Var6=E1
% T.Var7=E2
% T.Var8=E3
% T.Var9=RD
% T.Var10=ADC