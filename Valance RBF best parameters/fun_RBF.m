function [err1, err2] = fun_RBF(xtrain, ytrain, xtest, ytest, RBF_parameters)
xx = xtrain';
tt = ytrain';
net = newrb(xx,tt,RBF_parameters(1), RBF_parameters(2), RBF_parameters(3), RBF_parameters(4));
% view(net)
y = sim(net,xtest');

%%
classes_network = y;
classes_real    = ytest';

err1 = perform (net, classes_real, classes_network);
[num_err, err_percent] = num_miss_classified(classes_real', classes_network);      %ytest nsample*1    y 1*nsample
err2 = sum(num_err);

figure; plotregression(classes_real,classes_network);

