%read in stats file
addpath('/Volumes/CivmUsers/omega/Documents/MATLAB/alex/fdr_bh/fdr_bh.m') 
addpath('/Volumes/CivmUsers/omega/Documents/MATLAB/alex/fdr_bh/')
addpath('/Volumes/CivmUsers/omega/Documents/MATLAB/alex/cvn/')

% %0 CVN; 1 is CTRL
% genotype=[ 
% 1
% ];


%allrunnos={  'N51124',  'N51130' ,'N51393','N51392','N51390', 'N51388','N51136', 'N51133' ,'N51282', 'N51234','N51201','N51241','N51252','N51383','N51386','N51231','N51404','N51406','N51221','N51193','N51221','N51182','N51151','N51131','N51164'}


cvn_predictors = readtable('/Volumes/CivmUsers/omega/Documents/MATLAB/alex/cvn/predictors_cvn_march2015.csv');
allrunnos=cvn_predictors.RUNNO;

gender0=cvn_predictors.GENDER;
weight0=cvn_predictors.WEIGHT;
age0=cvn_predictors.AGE_WEEKS; 
genotype0=cvn_predictors.GENOTYPE;  %given here in the first lines, no need to



path_in='/Volumes/cretespace/alex/agoston_spm/bj/labels/statsin/'; %N51393_crstats.txt
path_out='/Volumes/cretespace/alex/agoston_spm/bj/labels/statsout/';



%runnos=allrunnos
ind_outliers=[find(strcmp(allrunnos, 'N51193')) ]; %N51193; N51221; %9 and 7 = 16 runnos
ind_outliers=-1;
ind_outliers=[find(strcmp(allrunnos, 'N51193')) find(strcmp(allrunnos, 'N51221'))]; %N51193; N51221
if ind_outliers > 1 
    genotype0(ind_outliers)=-1
end

ind1=intersect(find(genotype0 ==1 ),find(60<age0 & age0<87)); %CTRL-NOS
ind2=intersect(find(genotype0 ==2 ),find(60<age0 & age0<87)) ;%CVN

ind1=[1:6];
ind2=[7:12];
ind=[ind1' ind2']
gender=gender0(ind)
weight=weight0(ind);
age=age0(ind);
genotype=genotype0(ind);
runnos=allrunnos(ind);


index_ctrl=numel(ind1);
index_cvn=numel(ind2);


TableAlx = table(gender,weight,age, genotype,runnos, 'VariableNames', {'Gender' 'Weight' 'Age' 'Genotype' 'Runno'});


for i=1:numel(runnos)
    runno=runnos{i}
    mystatsfile=[path_in runno '_crstats.txt']
    T=0;
    T=readtable(mystatsfile,'HeaderLines',2,'Delimiter','\t');

 
    vol(i,:)=T.Var3; % T(:,3); %
    dwi(i,:)= T.Var4;%T(:,4);%
    fa(i,:)=T.Var5;%T(:,5);%
    e1(i,:)=T.Var6;% T(:,6);%
    e2(i,:)=T.Var7;%T(:,7);%
    e3(i,:)=T.Var8;%T(:,8);%
    rd(i,:)=T.Var9;%T(:,9);%
    adc(i,:)=T.Var10;%T(:,10);%
end


dlmwrite([path_out,'vol.txt'], vol, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
dlmwrite([path_out,'dwi.txt'], dwi, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
dlmwrite([path_out,'fa.txt'], fa, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
dlmwrite([path_out,'e1.txt'], e1, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
dlmwrite([path_out,'e2.txt'], e2, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
dlmwrite([path_out,'e3.txt'], e3, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
dlmwrite([path_out,'rd.txt'], rd, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
dlmwrite([path_out,'adc.txt'], adc, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);

%dlmwrite([path_out,'shortpredictors.txt'], predictors, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
writetable(TableAlx, [path_out,'predictors_table.txt'] , 'WriteRowNames',true)

prefix='nooutlier'; %'all'; %


 
writemystats1(dwi(index_ctrl+1:end,2:end)',dwi(1:index_ctrl, 2:end)', [path_out 'cvn_stats_dwi' prefix ],0)
writemystats1(fa(index_ctrl+1:end,2:end)',fa(1:index_ctrl, 2:end)', [path_out 'cvn_stats_fa' prefix ],0)
writemystats1(e1(index_ctrl+1:end,2:end)',e1(1:index_ctrl, 2:end)',[path_out 'cvn_stats_e1' prefix ],0)
writemystats1(e2(index_ctrl+1:end,2:end)',e2(1:index_ctrl, 2:end)',[path_out 'cvn_stats_e2' prefix],0)
writemystats1(e3(index_ctrl+1:end,2:end)',e3(1:index_ctrl, 2:end)',[path_out 'cvn_stats_e3' prefix],0)
writemystats1(rd(index_ctrl+1:end,2:end)',rd(1:index_ctrl, 2:end)',[path_out 'cvn_stats_rd' prefix ],0)
writemystats1(adc(index_ctrl+1:end,2:end)',adc(1:index_ctrl, 2:end)',[path_out 'cvn_stats_adc' prefix ],0)
writemystats1(vol(index_ctrl+1:end,2:end)',vol(1:index_ctrl, 2:end)',[path_out 'cvn_stats_vol' prefix],1)


