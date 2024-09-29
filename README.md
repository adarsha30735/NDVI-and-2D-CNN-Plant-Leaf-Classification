# NDVI and 2D-CNN Plant Leaf Classification

This repository contains MATLAB implementations for classifying plant leaves based on NDVI and deep learning using 2D-CNN (AlexNet). It includes MATLAB App Designer integration, image pre-processing for training, and classification of healthy and diseased plant leaves.

## Table of Contents
- [Introduction](#introduction)
- [Script Code](#script-code)
  - [Image Resizing](#image-resizing)
  - [NDVI Classification Using MATLAB App Designer](#ndvi-classification-using-matlab-app-designer)
  - [2D-CNN Classification Using AlexNet](#2d-cnn-classification-using-alexnet)
- [Dataset](#dataset)
- [Results and Analyses](#results-and-analyses)
- [Usage](#usage)

## Introduction

This project aims to classify plant leaves into healthy and unhealthy categories using two main methods:  
1. NDVI-based classification through MATLAB App Designer.
2. Deep learning classification using a 2D Convolutional Neural Network (CNN) based on AlexNet.

### Key Objectives:
- Perform NDVI-based image classification using near-infrared (NIR) and RGB images.
- Use transfer learning on AlexNet for classification of diseased and healthy plant leaves.
- Integrate NDVI and CNN classification in a MATLAB App Designer interface.

## Script Code

### Image Resizing

The `Image_Resizev2.m` script resizes large plant leaf images to a resolution of 227 x 227 pixels, making them suitable for input into AlexNet for 2D-CNN classification.

#### Full Code:
```matlab
output_address = ('E:\\UNL\\semester 1\\CSI 8300 cv and ıp\\PA_B\\leaf\\Test\\Pongamia Pinnata (P7)\\Unhealthy Plants');
current_folder = dir('E:\\UNL\\semester 1\\CSI 8300 cv and ıp\\PA_B\\leaf\\Test\\Pongamia Pinnata (P7)\\diseased\\*.jpg');

for i = 1 : length(current_folder)
    current_image = current_folder(i).name;
    Img = imread(fullfile(current_folder(i).folder, current_image));
    j = imresize(Img, [227, 227], 'bilinear');
    imwrite(j, fullfile(output_address, current_image));
end

