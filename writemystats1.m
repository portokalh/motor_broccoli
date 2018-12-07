function writemystats1(vcvn,vnos,fileout,vols,paired)
%example call
%set vols to 1 if dealing with volumes, this will run stats on normalized
%brain regions volumes and total brain on last line
%otherwise vols should be set to 0
%paired is 0 for 2 grpup testing; 1 for paired  t tests
    
% vcvn=[11.24746792	11.3979905	11.697399	11.48253298	10.99592152	11.28894936	11.22198677
% 5.678655447	5.949127232	5.860198451	5.844138121	5.413337681	5.965396624	5.300582611
% 5.520288294	5.506840929	5.678388143	5.904871337	5.497604617	5.276085483	5.577152314
% 4.998496854	4.882386348	4.689970045	5.275532909	4.829244869	4.544644018	4.883058043
% 3.716259744	3.689531275	3.630242589	3.860238296	3.790030086	3.639626867	3.713043392
% 2.760121778	2.965817375	2.735402161	2.679585314	2.79757865	2.786895898	2.974694209
% 2.666100601	2.62961306	2.675924829	2.554975132	2.480176288	2.406608497	2.510753662
% 2.097902515	2.047762592	2.190383609	2.051611485	2.15213604	1.973626794	2.032860132
% 1.690114548	1.660869151	1.761639278	1.726163681	1.70021937	1.714063806	1.692147432];
% 
% vnos=[10.79018431	11.3979905	11.25108158	11.2639322	11.11260123	10.81853104	11.19302129	10.97470473
% 6.228749811	5.949127232	6.684119491	5.592196277	6.027320945	6.278849396	6.46939904	6.109205995
% 6.220405597	5.506840929	5.975263727	5.796502029	5.612593817	5.973080669	5.635417395	5.726249707
% 4.958241153	4.882386348	4.806089034	4.922386076	4.789703492	4.694638409	4.852513996	4.887520587
% 3.851656908	3.689531275	3.784290587	3.868134244	3.808995618	3.734366639	3.7916221	3.786022242
% 2.636157077	2.965817375	2.716684859	2.563479818	2.637383985	2.623951948	2.512500027	2.701596106
% 2.606322582	2.62961306	2.459078461	2.50404268	2.427304885	2.564635623	2.380504793	2.378668435
% 2.17436003	2.047762592	2.096091492	1.983235412	1.928129625	2.199550567	2.204996066	2.227955874
% 1.778576724	1.660869151	1.77368787	1.841530308	1.727263352	1.757492991	1.866974472	1.720349733]
% 
% fileout='cvn14_18_vs_allnos'

% writemystats(vcvn,vnos,fileout) 

no_cvn=size(vcvn)
no_cvn=no_cvn(2)

no_nos=size(vnos)
no_nos=no_nos(2)

no_labels=size(vnos);
no_labels=no_labels(1) ; %error checking against vcvn; the fist size elements should be equal 
%if dealing with volumes mornalize first

    if vols==1;
        brain_vcvn=sum(vcvn);
        brain_vnos=sum(vnos);
    vcvn=100*vcvn./repmat(sum(vcvn),no_labels,1);
    vnos=100*vnos./repmat(sum(vnos),no_labels,1);
    %APPEND BRAIN
    vcvn=[vcvn;brain_vcvn];
    vnos=[vnos;brain_vnos];
    end

if paired==0 
    [h p table stats]=ttest2(vcvn',vnos')
else
    [h p table stats]=ttest(vcvn',vnos')
end

%[hBH, crit_p, adj_p]=fdr_bh(p,0.05,'pdep','yes');
[pthr_0p25,cor_p0p25,adj_p]=fdr(p,0.05)


[ppermute,tpermute,dfpermute]=mattest(vcvn,vnos,'Permute', 1000)


pooledsd=sqrt(std(vnos').^2/no_nos+std(vcvn').^2/no_cvn);
pooledsd=sqrt((no_nos-1).*std(vnos').^2+(no_cvn-1).*std(vcvn').^2)./sqrt(no_nos+no_cvn-2);
cohen_d=-(mean(vnos')-mean(vcvn'))./pooledsd;
difference=-(mean(vnos')-mean(vcvn'))*100./mean(vnos');

ci_l_cvn=mean(vcvn')-1.96*std(vcvn');
ci_h_cvn=mean(vcvn')+1.96*std(vcvn');
ci_l_nos=mean(vnos')-1.96*std(vnos');
ci_h_nos=mean(vnos')+1.96*std(vnos');


%% 

%adj_p; 
mystats=[mean(vcvn'); mean(vnos') ;std(vcvn'); std(vnos') ;std(vcvn')/sqrt(no_cvn); std(vnos')/sqrt(no_nos); ci_l_cvn; ci_l_nos; ci_h_nos; ci_h_cvn; h; p; adj_p; ppermute'; table;stats.tstat;cohen_d;difference];
% path='~/Colton_data/    '
% path='/Volumes/cretespace/SHANK3/'
% path='/Users/alex/cvn_stats/out_stats/';

%path='/Volumes/alex_home/AlexBadea_MyPapers/TNF/out_stats/';
%fileout1=[path fileout '.txt']
fileout1=[fileout '.txt']

myheader={'mean_treated', 'mean_control', 'std_treated', 'std_control', 'sem_treated', 'sem_control', 'ci1_treated','ci2_cvn','ci1_control','ci2_control', 'hypothesis', 'p_value', 'pFDR', 'ppermute', 'CI[1]', 'CI[2]', 't_stats', 'cohen_d' ,'difference'};
fid = fopen(fileout1, 'a');
for row=1:length(myheader)
    fprintf(fid, '%s %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n', myheader{:,row});
end
fclose (fid)



%dlmwrite(output_stats, header, 'precision', '%s', 'delimiter', '', '-append','roffset', 1);
dlmwrite(fileout1, mystats', 'delimiter', '\t', 'precision', '%10.8f', '-append','roffset', 1);
     




end
