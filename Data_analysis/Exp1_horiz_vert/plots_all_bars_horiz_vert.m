clear all;close all;

%% Putting in data

% load bar_4_poster_glass.mat
subject_name = {'S1','S2','S3','S4','S5','S6','S7','S8'};
num_sub = length(subject_name);
% cd('Bootstrap_data');
for i=1:num_sub
    load([subject_name{i},'_' ,'horiz', '.mat']);
    load([subject_name{i},'_' ,'vert', '.mat']);
end;

%% SECTION TITLE
% DESCRIPTIVE TEXT

threshOut_v=[];
diffBoot_v=[];
for i = 1:num_sub
eval(['threshOut_v = [threshOut_v;threshOut_',subject_name{i},'_1','];']);
eval(['diffBoot_v = [diffBoot_v, diff(bootThreshOut_',subject_name{i},'_1',',1,2)','];']);
end

threshOut_h=[];
diffBoot_h=[];
for i = 1:num_sub
eval(['threshOut_h = [threshOut_h;threshOut_',subject_name{i},'_2','];']);
eval(['diffBoot_h = [diffBoot_h, diff(bootThreshOut_',subject_name{i},'_2',',1,2)','];']);
end

%% threshold raw
threshOut_v=threshOut_v';
threshOut_h=threshOut_h';

fontSize = 18;
threshDiff_v = diff(threshOut_v);
threshDiff_h = diff(threshOut_h);
threshDiff_diff = threshDiff_v-threshDiff_h;
threshDiff_diff =[threshDiff_diff mean(threshDiff_diff)];

threshDiff_v = [threshDiff_v mean(threshDiff_v)];
threshDiff_h = [threshDiff_h mean(threshDiff_h)];
%% Bootstrap data
diffBoot_v = squeeze(diffBoot_v)';
diffBoot_h = squeeze(diffBoot_h)';
diffBoot_diff = diffBoot_v-diffBoot_h;
diffBoot_diff = [diffBoot_diff; mean(diffBoot_diff)];
CI_diff = 1.96*std(diffBoot_diff,[],2);

diffBoot_v = [diffBoot_v;mean(diffBoot_v)];
CI_v = 1.96*std(diffBoot_v,[],2); 

diffBoot_h = [diffBoot_h;mean(diffBoot_h)];
CI_h = 1.96*std(diffBoot_h,[],2);

%% Ploting
figure;
hold on;
subplot(3,2,1);
b = bar(threshOut_v',0.8,'EdgeColor','none');
b(1).FaceColor=[0 0 0.7];
b(2).FaceColor=[0.7 0 0];
ylabel('PSE (deg)')
Format_graphs;
set(gca,'XTickLabel',{'S1' 'S2' 'S3' 'S4' 'S5','S6','S7','S8'});
title('Vertical meridian');
%title('Up/down occluder');
%%
subplot(3,2,3);
h=bar([1:num_sub,num_sub+2], threshDiff_v,0.8,'EdgeColor','none');
set(h,'FaceColor',[0 .5 0]);
hold on;
errorbar([1:num_sub num_sub+2],threshDiff_v,CI_v,CI_v,'k','LineStyle','none','LineWidth',2)
Format_graphs;
set(gca,'XTickLabel',{'S1' 'S2' 'S3' 'S4' 'S5' 'S6' 'S7' 'S8' 'Avg'})
ylabel('Diff of PSEs (deg)')
title('Vertical meridian');

%%
hold on;
subplot(3,2,2);
b = bar(threshOut_h',0.8,'EdgeColor','none');
b(1).FaceColor=[0 0 0.7];
b(2).FaceColor=[0.7 0 0];
ylabel('PSE (deg)')
Format_graphs;
set(gca,'XTickLabel',{'S1' 'S2' 'S3' 'S4' 'S5','S6','S7','S8'});
title('Horizontal meridian');
%title('Up/down occluder');
%%
subplot(3,2,4);
h=bar([1:num_sub,num_sub+2], threshDiff_h,0.8,'EdgeColor','none');
set(h,'FaceColor',[0 .5 0]);
hold on;
errorbar([1:num_sub num_sub+2],threshDiff_h,CI_h,CI_h,'k','LineStyle','none','LineWidth',2)
Format_graphs;
set(gca,'XTickLabel',{'S1' 'S2' 'S3' 'S4' 'S5' 'S6' 'S7' 'S8' 'Avg'})
ylabel('Diff of PSEs (deg)')
title('Horizontal meridian');

%% Plotting 2
subplot(3,2,5:6);
h=bar([1:num_sub,num_sub+2], threshDiff_diff,0.8,'EdgeColor','none');
set(h,'FaceColor',[0.5 0.5 0.5]);
hold on;
errorbar([1:num_sub num_sub+2],threshDiff_diff,CI_diff,CI_diff,'k','LineStyle','none','LineWidth',2)
Format_graphs;
set(gca,'XTickLabel',{'S1' 'S2' 'S3' 'S4' 'S5' 'S6' 'S7' 'S8' 'Avg'})
ylabel('Diff of PSEs (deg)');
title('Vertical - Horizontal meridian');
%%
figure;
Format_graphs;
h=bar([1,2,3],[threshDiff_v(end),threshDiff_h(end),threshDiff_diff(end)],0.6,'EdgeColor','none');
set(h,'FaceColor',[0.5 0.5 0.5]);
hold on;
errorbar([1,2,3],[threshDiff_v(end),threshDiff_h(end),threshDiff_diff(end)],[CI_v(end),CI_h(end),CI_diff(end)],'k.','LineWidth',2)
ylabel('Mean PSE diff (dva)');
Format_graphs;
set(gca,'XTickLabel',{'Vertical','Horizontal','Vert - Horiz'})