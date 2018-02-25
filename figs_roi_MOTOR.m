path_out='/Users/alex/brain_data/motor/25october2016/roi_stats2/statsout/';
pathfigs=[path_out '/figs/']
indcontrol=1:12;
indreacher=13:24;
G=[repmat({'Control '},1,12) repmat({'Reacher '},1,12) ];
w=1.5

fa2=dlmread([path_out,'fa.txt']) ;
fa=[fa2(indcontrol,:) ;fa2(indreacher,:) ];


vol2=dlmread([path_out,'vol.txt']) ;
vol=[vol2(indcontrol,:) ;vol2(indreacher,:) ];


myfigflag=1

fileID = fopen('/Users/alex/brain_data/motor/25october2016/roi_stats2/statsout/mylegend.csv');
legend = textscan(fileID,'%s ');
fclose(fileID);
%celldisp(legend)

%%%%%%

%%%%%%%

%%%%%%%
if myfigflag==1

    ind=[287
314
303
137
90
143
136
257
307
166
326
283
173
261
267
119
282
120
147
262
145
304
59
142]

figure(1)
for j=1:numel(ind)
    k=ind(j)
    if ind(j)<=167 mylegend=['R ' strrep(legend{1}{k}, '_', '')];
     else mylegend=['L ' strrep(legend{1}{k}, '_', '')];
    end
    
 mytitle=['FA_' mylegend]
 mysize=3;
 set(gca, 'FontSize', 18, 'LineWidth', 3); %<- Set properties
 set(gca,'XTick',[1 2 ]);
 boxplot(fa(:,k), G, 'whisker',w,'notch', 'off')
 title(['FA ' char(mylegend)],'FontSize', 18)
 
 if ind(j) <=167 print([pathfigs mytitle '_R.png'],'-dpng','-r300');
    else print([pathfigs mytitle '_L.png'],'-dpng','-r300');
 end
 
end

ind=[119
286
301
133
83
130
129
297
300
289
139
57
131
296
127
323
122
288
250
191
112
252
306
247
270
121
318
150
271
275
304
84
278
53
135
28
134
295
128
144
293
262
124
95
298
63
220
195
20
238
193
109
303
]

ind=[ 57 191 112 252 270 150 84 278 262 94 63 20 193];

for j=1:numel(ind)
    k=ind(j)
     if ind(j)<=167 mylegend=['R ' strrep(legend{1}{k}, '_', '')];
     else mylegend=['L ' strrep(legend{1}{k}, '_', '')]
    end
    
 mytitle=['VOL_' mylegend]
 mysize=3;
 set(gca, 'FontSize', 18, 'LineWidth', 3); %<- Set properties
 set(gca,'XTick',[1 2 ]);
 boxplot(vol(:,k), G, 'whisker',w, 'notch', 'off')
 title(['VOL ' char(mylegend)],'FontSize', 18)
 
 if ind(j) <=167 print([pathfigs mytitle '_R.png'],'-dpng','-r300');
    else print([pathfigs mytitle '_L.png'],'-dpng','-r300');
 end
 
end


brain=sum(vol,2)-vol(:,1)-vol(:,168);

nvol=repmat(brain,1,334);
 normedbrain=vol./nvol;   
    %APPEND BRAIN
    normed=[normedbrain brain];
    
ind=[ind 335]
for j=1:numel(ind)
    k=ind(j)
  if k<=167 mylegend=['R ' strrep(legend{1}{k}, '_', '')];
  elseif 168<=k<335 mylegend=['L ' strrep(legend{1}{k}, '_', '')];
  elseif k==335 mylegend='Brain';
    end
    
 mytitle=['NormedVOL_' mylegend]
 mysize=3;
 set(gca, 'FontSize', 18, 'LineWidth', 3); %<- Set properties
 set(gca,'XTick',[1 2 ]);
 boxplot(normed(:,k), G, 'whisker',w,'notch', 'off')
 title(['NormedVol ' char(mylegend)],'FontSize', 18)
 
 if ind(j) <=167 print([pathfigs mytitle '_R.png'],'-dpng','-r300');
    else print([pathfigs mytitle '_L.png'],'-dpng','-r300');
 end
end

end
