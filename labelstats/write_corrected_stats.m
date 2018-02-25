function write_corrected_stats(cell_array_of_niftis,output_labels,output_stats,atlasid)
%write stats
% taking
% cell array of niftis
%    first is the label file to be loaded the rest are all the volumes to
%    measure based on the labels
% output labels
%    label file output, we ... renoamlize the label field in processing 
% output stats, path to write a text file to
% atlas id, which of the atlases was used to create labels
%    this is useful for writing out the correct label names, not that we do
%    much with it yet. 
%   
%sample call
%
%write_stats ( {'/cretespace/N51131_m0Labels-results/dwi_labels_warp_N51131_m0.nii','/cretespace/N51131_m0Labels-work/N51131_m0_DTI_dwi_strip_reg2_DTI.nii','/cretespace/N51131_m0Labels-work/N51131_m0_DTI_fa_reg2_dwi_strip_reg2_DTI.nii','/cretespace/N51131_m0Labels-work/N51131_m0_DTI_e1_reg2_dwi_strip_reg2_DTI.nii','/cretespace/N51131_m0Labels-work/N51131_m0_DTI_e2_reg2_dwi_strip_reg2_DTI.nii'},'/cretespace/N51131_m0Labels-results/dwi_labels_warp_N51131_m0_cr.nii','/cretespace/N51131_m0Labels-results/dwi_labels_warp_N51131_m0_stats.txt','DTI' )


%mytemptxt=regexpi(cell_array_of_niftis{1},'_', 'split');
%t=mytemptxt(end); % because of how the filesa re saved this needs to pull out the last part to get the run number.
%label_hdr=[t{1} '_labels'];% assign the runumber to label_header
label_hdr=regexpi(cell_array_of_niftis{1},'[^/]*Labels','match'); % grab the whateverLabels of your seg_pipe run. 
label_hdr=label_hdr{1};


myheader={label_hdr , 'label_voxels',  'volumes(mm3)'} ;

for i=2:length(cell_array_of_niftis)
    fprintf('\t%s\n',cell_array_of_niftis{i});
    [path name ext ]= fileparts(cell_array_of_niftis{i});
    mytemptxt=regexpi(name,'_', 'split'); 
    %%%%%%myheaderi{i}=mytemptxt(5)
    regmatch=regexpi(atlasid,'dti','match');
    if numel(regmatch)>=1 %strcmp(atlasid,regmatch{1})  % if it doesnt match the regmatch cellarray will be empty with 0 elements
        myheader=[myheader, mytemptxt(3)]
    else
        myheader=[myheader,name];
    end
end
fprintf('Header on output \n>\t%s\n',strjoin(myheader,','));



%for label volumes

label_nii=cell_array_of_niftis{1};
label_orig=load_untouch_nii(label_nii);
%can get voxel_vol from here, so no need for vsize to be passed
voxel_vol=label_orig.hdr.dime.pixdim(2)*label_orig.hdr.dime.pixdim(3)*label_orig.hdr.dime.pixdim(4);
labelim=100*double(label_orig.img);
labelim_new=label_orig.img*0;
label_names=['Exterior'	,	...
'Cerebral_cortex	',	...
'Brainstem	'	,...
'Thalamus	'	,...
'Superior_Colliculus   ',	...	
'Inferior_Colliculus   '	,	...
'Lateral_lemniscus	',	...
'Periaqueductal_gray	'	,...
'Septal_nuclei_complex_lateral	 '	,...
'Ventral_nuclei_of_the_thalamus_VPL_VPM_VP_VA	',	...
'Anterior_commissure   '		,...
'Pontine_gray	',	...
'Substantia_nigra   '		,...
'Cerebral_peduncle   '		,...
'Interpeduncular_nucleus'	,	...
'Globus_pallidus   ',		...
'Internal_capsule   ',		...
'Deep_mesencephalic_nuclei   '	,	...
'Lateral_dorsal_nucleus_of_thalmus	',	...
'Medial_Geniculate	'	,...
'Anterior_pretectal_nucleus	'	,...
'Optic_tract'		,...
'Ventricular_system		',...
'Striatum	'	,...
'Hippocampus   '	,	...
'Fimbria   '		,...
'Corpus_callosum   ',	...	
'Lateral_Geniculate   	'	,...
'Fornix	   '	,...
'Aqueduct   '	,	...
'Pineal_Gland	',	...
'Amygdala	'	,...
'Hypothalamus   '	,	...
'Nucleus_accumbens    '	,	...
'Olfactory_areas   ',		...
'Cochlear_nuclei   ',		...
'Spinal_trigeminal_tract   ',	...	
'Cerebellum	   '	];

label_test=label_orig;
val1=unique(labelim)
l=length(cell_array_of_niftis);
n=length(val1)
ar1=1:n
volumes=ar1*0.0;
mystats=zeros(n,length(cell_array_of_niftis));
ind_mask=find(labelim);%check if used

label_test.hdr=label_orig.hdr;

%%%
for i=2:length(cell_array_of_niftis)
        %get index for each region
        %get fa values, e1 values, e2 values etc for each region
        filenii_i=cell_array_of_niftis{i};
        fprintf('load nii %s\n',filenii_i);
        imnii_i=load_untouch_nii(filenii_i);
        for ind=1:numel(val1)
            fprintf('region %d processing\n',ind);
            labelim_new(labelim==val1(ind))=ind;
            volumes(ind)=numel(find(labelim==val1(ind)));
            regionindex=find(labelim==val1(ind));
            mystats(ind,1)=mean(labelim(regionindex));
            
            mystats(ind,i)=mean(imnii_i.img(regionindex));
        end
    end



%%%%
% for ind=1:length(ar1)
%     labelim_new(labelim==val1(ind))=ar1(ind);
%     volumes(ind)=numel(find(labelim==val1(ind)));
%     regionindex=find(labelim==val1(ind));
%     mystats(ind,1)=mean(labelim(regionindex));
%     for i=2:length(cell_array_of_niftis)
%         %get index for each region
%         %get fa values, e1 values, e2 values etc for each region
%         filenii_i=cell_array_of_niftis{i};
%         imnii_i=load_untouch_nii(filenii_i);
%         mystats(ind,i)=mean(imnii_i.img(regionindex));
%     end

    
%end


label_test.img=labelim_new;
file_nii_out=output_labels;
%save_nii(label_test, file_out);
save_untouch_nii(label_test, file_nii_out); 

% props = regionprops(labelim, 'Area');
% volumes=props.Area;
%% 

volumes_unit=volumes*voxel_vol;

%% 
%% 
M=[ar1; volumes; volumes_unit;mystats(:,2:l)']';


if strcmp(atlasid,'whs')
    label_key=['if_using_whs_as_reference_the_label_names_are: ', label_names];
else
    label_key=['Not_using_WHS_labels_no_label_key_provided'];
end
dlmwrite(output_stats, label_key, 'precision', '%s', 'delimiter', ' ','roffset', 1);
%header={'label' , 'number of voxels',  'volumes (mm3)', myheader }';

fid = fopen(output_stats, 'a');
for row=1:length(myheader)
    fprintf(fid, '%s %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d \n', myheader{:,row});
end
fclose (fid)



%dlmwrite(output_stats, header, 'precision', '%s', 'delimiter', '', '-append','roffset', 1);
dlmwrite(output_stats, M, 'delimiter', '\t', 'precision', '%10.8f', '-append','roffset', 1);
     




end
