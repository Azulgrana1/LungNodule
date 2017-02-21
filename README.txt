README

Model is trained with Caffe and tested with its MATLAB interface.
To test the model:
1.Add caffe's path to MATLAB
2.Change test data directory in testModel.m
3.Run testModel.m

Files originally provided:
calculate_auc.m 	Calculate area-under-curve
train_ground_truth.mat	Ground truth

Model files:
Res50_train_iter_20000.caffemodel	Weights of the model
ResNet_mean.binaryproto			Mean file
ResNet-50-deploy.prototxt		Model prototype

My scripts:
testModel.m	Read data, output predictions and AUC (Run this file for testing)
flatten.m	Converts 3D block to 2D image