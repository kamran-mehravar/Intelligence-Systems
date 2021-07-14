clc
clear
close all;

%% reading the dataset

% load('arousal data.mat')

load('new arousal after fuzzy.mat')
arousal_data = new_arousal;

d = arousal_data;
best_features = [24    29    14     9    10    21    3    11    23    5];
X = d(:,best_features);

Lable_arousal = round(d(:,end)); 

for i=1:7
    ind(i) = {(Lable_arousal==i)};
end
new_Lable_arousal = Lable_arousal;
% new_Lable_arousal(ind{1}|ind{2}|ind{3}) = 1;
% new_Lable_arousal(ind{4}) = 2;
% new_Lable_arousal(ind{5}|ind{6}|ind{7}) = 3;


%%
arcs = {[60 30]};
k_fold = 4;

value = k_fold_cross_validaion_arc(X, new_Lable_arousal, k_fold, arcs{1});



