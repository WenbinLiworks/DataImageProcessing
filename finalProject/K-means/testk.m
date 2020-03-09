clc;
close all;
I = imread('~/Downloads/BSDS/images/train/24063.jpg');
[m, n, p] = size(I);
k = 19;
%聚类中心随机选择，省略第三个参数
[C, label, J] = kmeans(I, k);
%恢复
I_seg = reshape(C(label, :), m, n, p);
figure
subplot(1, 2, 1), imshow(I, []), title('原图')
subplot(1, 2, 2), imshow(uint8(I_seg), []), title('聚类图')
figure
%绘制目标函数图像
plot(1:length(J), J, 'r-*'), xlabel('#iterations'), ylabel('Objective function')