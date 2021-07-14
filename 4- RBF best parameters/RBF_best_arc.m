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
% RBF_parameters = goal,spread,MN,DF
% goal      Mean squared error goal (default = 0.0)
% spread	Spread of radial basis functions (default = 1.0)
% MN        Maximum number of neurons (default is Q)
% DF        Number of neurons to add between displays (default = 25)
sp = 0.001 : 0.003: 0.01;
k_fold = 4;
for i = 1:length(sp)
    i
    sp(i)
    RBF_parameters = [0.0, sp(i), 1400, 200];
    value(i) = k_fold_cross_validaion_RBF(X, Lable_arousal, k_fold, RBF_parameters);
end



