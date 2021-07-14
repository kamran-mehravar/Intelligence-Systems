clc
clear
close all;

%% reading the dataset
load('valance data 30.mat')
d = arousal_data;

X = d(:,1:end-1);

Lable_arousal = round(d(:,end));

%% selecting the best 10 features for each network
num_gens = 10;
[best_coros, best_vs] = genetic_algorithm_for_feature_selection(X,Lable_arousal,num_gens)




% %% selecting the best 10 features for each network
% fun = @(xtrain, ytrain, xtest, ytest)...
%       (sum(fun_mlp_classifier(xtrain, ytrain, xtest, ytest) > 0.5));
% tic
% opts = statset('display','iter');
% c = cvpartition(Lable_arousal,'k',10);
% 
% niter = 100;
% fs = zeros(niter, size(X,2));
% for i = 1: 100
%     iter = i
%     [fs(i,:),history] = sequentialfs(fun,X,Lable_arousal,'cv',c,'options',opts)
% end
% sum_fs = sum(fs,1);
% elapse_time = toc
% 
% 
% %fs = sequentialfs(fun,X,Lable_valance,'cv',c,'options',opts)
% % after 18 tekrar
% % sorted = 34    33    15    52    35    32    1    16    31    28    26    20    19    9     7     3
% % m      = 3     3     3     2     3     2     2    2      1     1     1     1     1    1     1     1
% 
% 
