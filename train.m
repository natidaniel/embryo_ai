%% Train embryo model
clear;clc;close all

%% Data preparation
% put under path_train the input images path
path_train='\Embryos\labeled_data\';

% Data store
imds = imageDatastore(path_train,... 
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.75,'randomized');


%% Define deep classification network
net = resnet50;

lgraph = layerGraph(net);
net.Layers(1)

inputSize = net.Layers(1).InputSize;

numClasses = numel(categories(imdsTrain.Labels)); 
lgraph = removeLayers(lgraph, {'fc1000','fc1000_softmax','ClassificationLayer_fc1000'}); 
newLayers = [ 
    fullyConnectedLayer(numClasses,'Name','fc','WeightLearnRateFactor',10,'BiasLearnRateFactor',10) 
    softmaxLayer('Name','softmax') 
    classificationLayer('Name','classoutput')]; 
lgraph = addLayers(lgraph,newLayers); 
lgraph = connectLayers(lgraph,'avg_pool','fc');
 
%% Define data augmentation 
pixelRange = [-30 30];
imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange);
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain);
augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation);

% Model params
options = trainingOptions('adam',...
    'InitialLearnRate',1e-4,...
    'SquaredGradientDecayFactor',0.99,...
    'MaxEpochs',10,...
    'MiniBatchSize',24,...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',50, ...
    'ValidationPatience',Inf, ...
    'Verbose',false, ...
    'CheckpointPath','\Embryos\checkpoint',...
    'LearnRateSchedule','piecewise',...
    'LearnRateDropFactor',0.5,...
    'LearnRateDropPeriod',5,...
    'Plots','training-progress');
	
%% Model Train
[trainedNet] = trainNetwork(augimdsTrain,lgraph,options);
save ('trainedNet');

%% Model Validation
[YPred,probs] = classify(trainedNet,augimdsValidation);
accuracy = mean(YPred == imdsValidation.Labels)
plotconfusion(imdsValidation.Labels,YPred)

%% Model Visualization Sanity
idx = randperm(numel(imdsValidation.Files),20);
figure
for i = 1:20
    subplot(4,5,i)
    I = rgb2gray(readimage(imdsValidation,idx(i)));
    imshow(I,[]);
    label = YPred((idx(i)));
    title(string(label) + ", " + num2str(100*max(probs(idx(i),:)),3) + "%");
end