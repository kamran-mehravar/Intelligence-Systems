clc
clear
close all;

%% reading the dataset
load('dataset.mat');
d = table2array(dataset);

%% Removal of non numerical values
inf_val = isinf(d);
[rs_inf, cls_inf] = find(inf_val == 1);
d(rs_inf,:) = [];

% %% outliers removal
% outliers_removal_method = 'median';
% d = d(:, 3:end);
% % d = rmoutliers(d, outliers_removal_method);
% % d = removeoutliers(datain)

%% normalizing input features
d = d(:, 3:end);
dn = d ./ repmat(sum(abs(d),1),size(d,1),1);
X = dn(:,3:end);
X(:,24) = [];  % all of the values of this feature is 0
X(isnan(X)) = 0;
Lable_arousal = round(d(:,1)); 
Lable_valance = round(d(:,2));

num_features = size(X,2);
num_classes = max(Lable_arousal);
num_data = length(Lable_arousal);

figure();hist(Lable_arousal,1000)
figure();hist(Lable_valance,1000)
%% shifting the class labels
ind1 = (Lable_arousal >= 3.5);
ind2 = (Lable_valance >= 3.5);
Lable_arousal(ind1) =  Lable_arousal(ind1) - 1;
Lable_valance(ind2) =  Lable_valance(ind2) - 1;

ind1 = (Lable_arousal >= 6.5);
ind2 = (Lable_valance >= 6.5);
Lable_arousal(ind1) =  Lable_arousal(ind1) - 1;
Lable_valance(ind2) =  Lable_valance(ind2) - 1;

figure();hist(Lable_arousal,1000)
figure();hist(Lable_valance,1000)

Lable_arousal = Lable_valance;

%% outliers removal
el_ind_a = [];
for ci = 1:7
    ind_a = find(Lable_arousal == ci);
    center_a(ci,:) = sum(X(ind_a,:),1);
    dis = dist_to_center(X(ind_a,:),center_a(ci,:));
    sind = [];
    sval = [];
    [sval, sind] = sort(dis);
    num_data_in_class(ci) = length(ind_a);
    outlier_percent = 30;
    beg = round(num_data_in_class(ci) * (100 - outlier_percent) / 100);
    el_ind_a = [el_ind_a; ind_a(sind(beg:end))];
end
X(el_ind_a,:) = [];
Lable_arousal(el_ind_a) = [];

%% random selection for databalancing
%% data balance analyze
for ci = 1:7
    arousal_class_num_member(ci) = sum(Lable_arousal == ci);
end

arousal_class_num_member
b = (repmat(max(arousal_class_num_member),1,7) - arousal_class_num_member)
b_n = sum(b);

for iii = 1:b_n
    b = (repmat(max(arousal_class_num_member),1,7) - arousal_class_num_member);
    P_arousal = b/sum(b);
    P_arousal (arousal_class_num_member == 0) = 0;
    P_arousal = P_arousal .^ 4;
    P_arousal = P_arousal / sum(P_arousal);
    arousal_class_sel = Roulette_wheel_my(P_arousal, 1);
    
    selected_data_ind = randperm(arousal_class_num_member(arousal_class_sel),1);
    a = find(Lable_arousal == arousal_class_sel);
    selected_data = X(a(selected_data_ind),:);
    new_data = selected_data + selected_data .* ((rand(1, num_features)) * 0.0001 - 0.00005);
%     new_data = center_a(arousal_class_sel,:) + center_a(arousal_class_sel,:) .* ((rand(1, num_features)) * 0.0001 - 0.00005);
    X = [X; new_data];
    Lable_arousal = [Lable_arousal; arousal_class_sel];
    arousal_class_num_member(arousal_class_sel) = arousal_class_num_member(arousal_class_sel) + 1;
end
arousal_data = [X,Lable_arousal];
figure(); hist(Lable_arousal,100)
% fun_mlp_classifier_patternnet(X, Lable_arousal_ind, X, Lable_arousal_ind);
% fun_mlp_classifier_fitnet(X, Lable_arousal, X, Lable_arousal);
