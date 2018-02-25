
system(['mkdir ' batch_directory]);

mem_request_MB=num2str(35000)

shebang='#!/bin/bash';


pathin='/Users/alex/brain_data/motor/exvivolabels/';
numfiles=size(flist);
numfiles=numfiles(1)

sfid=fopen(mysbatch_file, 'w');
fprintf(sfid,'%s\n' ,shebang)


for ii=1:numfiles
  
% gradient step size  0.02; -t 2
myname=flist(ii).name;
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
%kellycmd=['/cm/shared/apps/ANTS/KellyKapowski -d 3 -s ' sfile ' -g ' gfile ' -w ' wfile ' -o '  thickfile];
mybatch_file=[batch_directory myroots2 '.bash'];
my_clus_batch_file=[clus_batch_directory myroots2 '.bash'];
cortthick_cmd=[' '];

fid=fopen(mybatch_file, 'w');
fprintf(fid,'%s\n' ,shebang)



sbatch_cmd = ['sbatch --mem=' mem_request_MB  ' -s -p defq --out=' clus_batch_directory '/slurm' num2str(ii) '.out ' my_clus_batch_file]
fprintf(sfid, '%s;\n',sbatch_cmd);

%fprintf(sfid,'sbatch --mem=%i -s -p defq --out=%s /slurm-%i.out %s\n',...
%    mem_request_MB ,clus_batch_directory,ii, my_clus_batch_file); 

% try it now, yuou're all set, %something is replacd by somevariable, so
% you  should be rady.
% not sure, but this should get the behavior yo'ure looking for. 
%[res,err]=system(sbatch_cmd, '-echo')

kellycmd=['/cm/shared/apps/ANTS/KellyKapowski -d 3 -s ' sfile ' -g ' gfile ' -w ' wfile ' -t 2 -r 0.01 -v -o '  thickfile];
kellycmd=['/cm/shared/apps/ANTS/KellyKapowski -d 3 -s ' sfile ' -g ' gfile ' -w ' wfile ' -t 2 -r 0.01 -m 3 -v -o '  thickfile];

fprintf(fid, '%s;\n',kellycmd);
fclose(fid)


end
fclose(sfid)


system('scp alex@serifos:///Users/alex/Documents/MATLAB/alex/motor/mysbatch/*.bash /glusterspace/alex/motor_cort_thick/sbatch/')

% sbatch_cmd = ['sbatch --mem='  memory_request_in_MB ' -s -p defq --out=' sbatch_directory '/slurm-%j.out ' mubatch_file]
% [res,msg]=system(sbatch_cmd);
 