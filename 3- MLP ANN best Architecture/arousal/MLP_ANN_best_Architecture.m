clc
clear
close all;

%% reading the dataset
load('arousal data.mat')
d = arousal_data;
best_features = [24    29    14     9    10    21    3    11    23    5];
X = d(:,best_features);

Lable_arousal = round(d(:,end));


%%
arcs = {[10 10], [20 10], [30 10], [40 10], [50 10], [60 10]...
[10 20], [20 20], [30 20], [40 20], [50 20], [60 20] ...
[10 30], [20 30], [30 30], [40 30], [50 30], [60 30]}

k_fold = 4;
arcs = {[60 30]}
for i = 1:length(arcs)
    i
    value(i) = k_fold_cross_validaion_arc(X, Lable_arousal, k_fold, arcs{i});
end



