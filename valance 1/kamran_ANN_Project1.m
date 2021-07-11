clc
clear
close all;

%% reading the dataset
load('valance data 30.mat');
d = arousal_data;

X = d(:,1:end-1);

%% data balance analyze
Lable_arousal = round(d(:,end)); 

% figure();hist(Lable_arousal,1000)
% figure();hist(Lable_valance,1000)

%% selecting the best 10 features for each network
fun = @(xtrain, ytrain, xtest, ytest)...
      (fun_mlp_classifier(xtrain, ytrain, xtest, ytest));

opts = statset('display','iter');
c = cvpartition(Lable_arousal,'k',4);

niter = 30;
fs = zeros(niter, size(X,2));
for i = 1: niter
    iter = i
    [fs(i,:),history] = sequentialfs(fun,X,Lable_arousal,'cv',c,'options',opts)
end
sum_fs = sum(fs,1);


%fs = sequentialfs(fun,X,Lable_valance,'cv',c,'options',opts)
% after 18 tekrar
% sorted = 34    33    15    52    35    32    1    16    31    28    26    20    19    9     7     3
% m      = 3     3     3     2     3     2     2    2      1     1     1     1     1    1     1     1


