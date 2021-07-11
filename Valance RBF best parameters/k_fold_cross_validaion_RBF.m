function err_percentage = k_fold_cross_validaion_RBF(X, y, k, RBF_parameters)
num_samples = size(X, 1);
rp = randperm(num_samples)';
err=zeros(1,k);
fold_size = floor(num_samples/k);

k_fold_test = cell(1,k);
k_fold_train = cell(1,k);
for ik = 1:k
    k_fold_test{1,ik} = rp(fold_size * (ik-1) + 1 : fold_size * ik);
    k_fold_train{1,ik} = [rp(1 : fold_size * (ik-1)) ; rp(fold_size * ik + 1 : end)];
end

for i5 = 1 : 1
    xtest = X(k_fold_test{i5},:);
    ytest = y(k_fold_test{i5});
    
    xtrain = X(k_fold_train{i5},:);
    ytrain = y(k_fold_train{i5});
%     size_xtest = size(xtest)
%     size_xtrain = size(xtrain)
    
    [err(i5), err2(i5)] = fun_RBF(xtrain, ytrain, xtest, ytest, RBF_parameters);
end

err_percentage = sum(err)/num_samples;


