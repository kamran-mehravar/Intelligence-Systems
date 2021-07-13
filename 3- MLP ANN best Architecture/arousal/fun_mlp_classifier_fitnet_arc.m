function [err1, err2] = fun_mlp_classifier_fitnet_arc(xtrain, ytrain, xtest, ytest, arcs)
% 1 input neuron , 1 output neuron
num_hiden_neuron = 40;               % num neurons for the hidden layer

net = feedforwardnet(arcs);
net.trainParam.showWindow =0;
% net = fitnet(num_hiden_neuron) ;
% net = patternnet(num_hiden_neuron);
% net.trainParam.showWindow =0;
index1 = randperm(size(xtrain,2),10);
xx = xtrain';
tt = ytrain';

net = train(net, xx(index1,:), tt);
% view(net)
y = net(xtest(:,index1)');


classes_network = y;
classes_real    = ytest';

[classes_real; classes_network];

% classes_network = vec2ind(y);
% classes_real    = vec2ind(ytest');

err1 = perform (net, classes_real, classes_network);
[num_err, err_percent] = num_miss_classified(classes_real', classes_network);      %ytest nsample*1    y 1*nsample
err2 = sum(num_err);
