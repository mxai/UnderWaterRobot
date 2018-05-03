%==========================================================================
%                   双目立体视觉--三维场景重建
%                     yuqingqing 2016.8.7
%==========================================================================

%==========================================================================
%     [1] 立体标定
%         matlab 自带的app，stereoCameraCalibrator（在命令窗中输入即可开启）
%         详情：http://cn.mathworks.com/help/vision/ug/stereo-camera-calibrator-app.html
%
%     [2] 立体校正
%         rectifyStereoImages函数
%
%     [3] 立体匹配 -- 视差图disparity
%
%     [4] 三维重建 -- Reconstruct the 3-D Scene
%
%==========================================================================
clc;clear;
% Load the stereoParameters object.
load('stereoParams90w.mat');

% Visualize camera extrinsics.
% showExtrinsics(stereoParams);

%% load image
img1 = rgb2gray(imread('1-03.png'));
img2 = rgb2gray(imread('2-03.png'));

%img1 = imresize(img1,[384,512]);
%img2 = imresize(img2,[384,512]);
% img1 = rgb2gray(imread('E:\camera\left1.jpg'));
% img2 = rgb2gray(imread('E:\camera\right1.jpg'));
%img3 = stereoAnaglyph(img1,img2);
imshow(stereoAnaglyph(img1,img2));%左右双目照片叠加显示

%% 立体校正
%[img1_valid,img2_valid] = rectifyStereoImages(img1, img2, stereoParams88w, 'OutputView', 'full');
[img1_valid,img2_valid] = rectifyStereoImages(img1,img2, stereoParams90w,'OutputView','valid');
% [J1_full,J2_full] = rectifyStereoImages(I1,I2,stereoParams,'OutputView','full');%全校正
figure;
% imshowpair(img1_valid,img2_valid,'falsecolor','ColorChannels','red-cyan');

imshow(stereoAnaglyph(img1_valid,img2_valid));
%imtool(stereoAnaglyph(img1_valid,img2_valid));

%% disparity
disparityRange = [0 64];
disparityMap = disparity(img1_valid,img2_valid,'BlockSize',15,'DisparityRange',disparityRange,'Method','SemiGlobal');
figure
imshow(disparityMap,disparityRange);
title('Disparity Map');
colormap jet
colorbar

%% Reconstruct the 3-D Cloud
% Reconstruct the 3-D world coordinates of points corresponding to each
% pixel from the disparity map.
point3D = reconstructScene(disparityMap, stereoParams90w);

ptCloud = pointCloud(point3D);

save('ptCloud.mat','ptCloud');

% pcshow(ptCloud);

figure;
subplot(2,2,1);
imshow(img1);
title('left');
drawnow;

subplot(2,2,3);
imshow(img2);
title('right');
drawnow;

subplot(2,2,[2,4]);
pcshow(ptCloud, 'VerticalAxis','Y', 'VerticalAxisDir', 'Down');%坐标轴转一下，方便观察
title('Initial world scene');
xlabel('X (mm)');
ylabel('Y (mm)');
zlabel('Z (mm)');
drawnow;

%贴纹理显示
% textureShowPointCloud;


