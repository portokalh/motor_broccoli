fileID = fopen('/Users/alex/brain_data/motor/25october2016/roi_stats2/statsout/mylegend.csv');
C = textscan(fileID,'%s');
fclose(fileID);
celldisp(C)

