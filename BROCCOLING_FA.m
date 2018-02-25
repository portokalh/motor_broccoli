my4dnii='/Users/alex/brain_data/motor4fsl/fa4d_2MDT.nii.gz'; %myjacs4d_2MDT.nii.gz'
PREFIX='FA'; %JACFIX


myshell_file='/Users/alex/Documents/MATLAB/alex/motor/broccoli_fa.sh'

shebang='#!/bin/bash';
cmd1=['/Users/alex/BROCCOLI-master/compiled/Bash/Mac/Release/RandomiseGroupLevel ' my4dnii ' -design bjac.mat -contrasts bjac.con -permutations 5000 -cdt 1.71 -inferencemode 2 -platform 0 -device 1 -mask MDT_mask_e3.nii.gz -output ' PREFIX 'corr'] 
cmd2=['fslsplit ' PREFIX 'corr_perm_tvalues.nii ' PREFIX 'corr_perm_tsplit -t']
cmd3=['fslsplit ' PREFIX 'corr_perm_pvalues.nii ' PREFIX 'corr_perm_psplit -t']


cmd4=['fslmaths ' PREFIX 'corr_perm_psplit0000.nii.gz -thr 0.94 -bin tmpthresh.nii.gz']
cmd5=['fslmaths tmpthresh.nii.gz -mul ' PREFIX 'corr_perm_tsplit0000.nii.gz ' PREFIX 'corr_perm_tvalues1thresh0p95.nii.gz']

cmd6=['fslmaths ' PREFIX 'corr_perm_psplit0001.nii.gz -thr 0.94 -bin tmpthresh.nii.gz']
cmd7=['fslmaths tmpthresh.nii.gz -mul ' PREFIX 'corr_perm_tsplit0001.nii.gz ' PREFIX 'corr_perm_tvalues2thresh0p95.nii.gz']
 

sfid=fopen(myshell_file, 'w');
cmd0=['export PATH=$PATH://Users/alex/BROCCOLI-master/compiled/Bash/Mac/Release'] 
cmd00=['export BROCCOLI_DIR=/Users/alex/BROCCOLI-master/']
fprintf(sfid,'%s\n' ,shebang)
fprintf(sfid, '%s;\n',cmd0);
fprintf(sfid, '%s;\n',cmd00);
fprintf(sfid, '%s;\n',cmd1);
fprintf(sfid, '%s;\n',cmd2);
fprintf(sfid, '%s;\n',cmd3);
fprintf(sfid, '%s;\n',cmd4);
fprintf(sfid, '%s;\n',cmd5);
fprintf(sfid, '%s;\n',cmd6);
fprintf(sfid, '%s;\n',cmd7);
fclose(sfid)