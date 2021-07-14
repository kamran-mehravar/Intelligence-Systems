clc
clear
close all
imDatasetPath = 'C:\Users\kamran\Desktop\ANN_Project\ANN project final codes\6-deep Learning\images';
faceImages =    imageDatastore(imDatasetPath,'FileExtensions','.jpg','includeSubfolder',true,'labelSource','folderNames');
T = countEachLabel(faceImages)

% Display some of the images in the datastore. 
figure
numImages = 1200;
perm = randperm(numImages,20);
for i = 1:20
    subplot(4,5,i);
    imshow(faceImages.Files{perm(i)});
    drawnow;
end

% Divide the datastore so that each category in the training set has 750 images and the testing set has the remaining images from each label. 
numTrainingFiles = 0.7 ; %you can use percentages to represent the divisions.    
[trainImages,testImages] = splitEachLabel(faceImages, numTrainingFiles,'randomize'); %the spliting is done randomly.
idx = randperm(numImages,100);
% xv = trainImages(:,:,:,idx);

% Define the convolutional neural network architecture. 
layers = [ ...
    imageInputLayer([224 224 3])
    
%    convolution2dLayer(5,20)
    convolution2dLayer(20 ,6 , 'Stride' ,4,'Padding','same')
    batchNormalizationLayer
    
    reluLayer
%     leakyReluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    %*****************************************%
    convolution2dLayer(10 ,10 , 'Stride' ,2,'Padding','same')
    batchNormalizationLayer
    reluLayer
   
    maxPooling2dLayer(2, 'Stride' ,2)
    %*****************************************%
    convolution2dLayer(32 ,8 , 'Stride' ,2,'Padding','same')
    batchNormalizationLayer
    reluLayer
   
    maxPooling2dLayer(2, 'Stride' ,2)
    %*****************************************%
    fullyConnectedLayer(60)
    fullyConnectedLayer(4)
    
    softmaxLayer
    
    classificationLayer];

% Igraph = layerGraph(layers)
% plot(Igraph)


% Set the options to the default settings for the stochastic gradient descent with momentum. Set the maximum number of epochs at 20, and start the training with an initial learning rate of 0.0001.
options = trainingOptions('sgdm', ...
    'MaxEpochs',250,...
    'InitialLearnRate',1e-4, ...
    'validationdata',faceImages,'validationfrequency',10, ...
    'Verbose',false, ...
    'Plots','training-progress');
    


% Train the network. 
net = trainNetwork(trainImages,layers,options);

% Run the trained network on the test set, which was not used to train the network, and predict the image labels (digits).
YPred = classify(net,testImages);
YTest = testImages.Labels;


% Calculate the accuracy. The accuracy is the ratio of the number of true labels in the test data matching the classifications from classify to the number of images in the test data.
accuracy = sum(YPred == YTest)/numel(YTest)
YPred = classify(net,faceImages);
YTest = faceImages.Labels;
figure; plotconfusion(YTest,YPred)


