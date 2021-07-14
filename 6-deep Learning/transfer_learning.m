clc
clear
close all
imDatasetPath = 'C:\Users\kamran\Desktop\ANN_Project\ANN project final codes\6-deep Learning\images';
faceImages =    imageDatastore(imDatasetPath,'FileExtensions','.jpg','includeSubfolder',true,'labelSource','folderNames');
T = countEachLabel(faceImages)

% Divide the data into training and validation data sets. Use 70% of the images for training and 30% for validation. splitEachLabel splits the images datastore into two new datastores.
[imdsTrain,imdsValidation] = splitEachLabel(faceImages,0.7,'randomized');

% Load Pretrained Network
net = alexnet;

% Use analyzeNetwork to display an interactive visualization of the network architecture and detailed information about the network layers.
analyzeNetwork(net)

% The first layer, the image input layer, requires input images of size 227-by-227-by-3, where 3 is the number of color channels. 
inputSize = net.Layers(1).InputSize

% Replace Final Layers
layersTransfer = net.Layers(1:end-3);

numClasses = numel(categories(imdsTrain.Labels))

layers = [
    layersTransfer
%     fullyConnectedLayer(20)
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];

% Train Network
pixelRange = [-30 30];
imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange);
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
    'DataAugmentation',imageAugmenter);

% To automatically resize the validation images without performing further data augmentation, use an augmented image datastore without specifying any additional preprocessing operations.
augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation);

% Specify the training options. 
options = trainingOptions('sgdm', ...
    'MiniBatchSize',10, ...
    'MaxEpochs',10, ...
    'InitialLearnRate',1e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',3, ...
    'Verbose',false, ...
    'Plots','training-progress');

% Train the network that consists of the transferred and new layers. 
netTransfer = trainNetwork(augimdsTrain,layers,options);
[YPred,scores] = classify(netTransfer,augimdsValidation);

% Display four sample validation images with their predicted labels.
idx = randperm(numel(imdsValidation.Files),4);
figure
for i = 1:4
    subplot(2,2,i)
    I = readimage(imdsValidation,idx(i));
    imshow(I)
    label = YPred(idx(i));
    title(string(label));
end
YTest = imdsValidation.Labels;
accuracy = sum(YPred == YTest)/numel(YTest)
figure;plotconfusion(YTest,YPred)





