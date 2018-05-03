clc;clear;
% Load the stereoParameters object.
load('stereoParams87w.mat');

img1 = rgb2gray(imread('1-02.jpg'));
img2 = rgb2gray(imread('2-02.jpg'));

[img1_valid,img2_valid] = rectifyStereoImages(img1, img2, stereoParams, 'OutputView', 'valid');
img3 = stereoAnaglyph(img1_valid,img2_valid);
imshow(img3);