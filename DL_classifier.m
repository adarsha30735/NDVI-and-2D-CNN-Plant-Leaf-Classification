

%train and validation using alex net

DatasetPath=('E:\UNL\semester 1\CSI 8300 cv and ıp\PA_B\leaf\Test\Pongamia Pinnata (P7)');

%Read images from the image folder
images=imageDatastore(DatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');

%disturbuting images in the set of training and testing
numTrainFiles=230;
[TrainImages,TestImages]=splitEachLabel(images,numTrainFiles,'randomize');

net= alexnet;
layersTransfer=net.Layers(1:end-3); 

%transfer learning

numClasses=2;

%define layers of Alexnet

layers=[
layersTransfer
fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
softmaxLayer
classificationLayer];

%Training options

options=trainingOptions( 'sgdm',...
    'MiniBatchSize',20,...
    'MaxEpochs',8, ...
    'InitialLearnRate', 0.0001,...
    'Shuffle','every-epoch', ...
    'ValidationData',TestImages,...
    'ValidationFrequency', 10, ...
    'Verbose', false,...
    'Plots','training-progress');
%training the Alexnet

netTransfer=trainNetwork(TrainImages, layers,options);

%classifying the Alexnet

Ypred=classify(netTransfer, TestImages);
YValidation=TestImages.Labels;
accuracy = sum(Ypred==YValidation)/ numel(YValidation)

% plot condusion matrix
plotconfusion(YValidation, Ypred);













