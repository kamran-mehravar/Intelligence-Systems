function err = fun_mlp_classifier(xtrain, ytrain, xtest, ytest)

num_hiden_neuron = 20;               % num neurons for the hidden layer
% net = fitnet(num_hiden_neuron) ;
net = feedforwardnet(40);
net.trainParam.showWindow =0;

xx = xtrain';
tt = ytrain';

net = train(net, xx, tt);
y=net(xtest');
% err = perform (net, ytest', y);
[num_err, err_percent] = num_miss_classified(ytest, y); %ytest nsample*1    y 1*nsample
err = sum(num_err);





