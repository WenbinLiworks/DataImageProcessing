% Flush out the MATLAB.
close all;
clc;

% Read the desired image file.
ImageData=imread('~/Downloads/Star.jpeg');

I = im2double(ImageData);

%%  use fspecial 预定义算子 sigmaValue.
SigmaValue = 1.0;
%input('Enter the Sigma = ');
blurred = fspecial('gaussian',50,SigmaValue); % [3,3]默认, Default sigma:0.5

%% Gaussian Filter implementation

BlurredImage = imfilter(ImageData,blurred,'replicate');
% replicate 图像大小通过赋值外边界进行扩展
% symmetric 通过镜像映射
%= imgaussfilt(I_Noise,SigmaValue);

%% Add Gaussian noise
NoiseValue = 0.00001 ; 
BlurredImageWithNoise = imnoise(BlurredImage,'gaussian',NoiseValue) ;
%% deblur 
Signal_var =  var(I(:));
NSR = NoiseValue / Signal_var;

I_wiener = deconvwnr(BlurredImageWithNoise,blurred,NSR);

%%
figure
% Display the original image.
subplot(1,2,1),imshow(uint8(ImageData)),title(' Original Image: ')
% Display the filter image
subplot(1,2,2),imshow(uint8(BlurredImage)),title(' Blurred Image: ')
figure
% Display the output with Noise
subplot(1,2,1),imshow(uint8(BlurredImageWithNoise)), title(' Blurred with noise: ')
% Display deblur
subplot(1,2,2),imshow(uint8(I_wiener)),title(' Final Image without blur');