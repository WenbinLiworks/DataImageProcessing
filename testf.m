clc;
close all;
I = imread('~/Downloads/BSDS/images/train/24063.jpg');
rng('default');
[m, n, p] = size(I);
X = reshape(double(I), m*n, p);
% k:num of clustering , b:¡• Ù∂» 
k = 17; b = 4; 
[C, dist, J] = fcm(X, k, b);
[~, label] = min(dist, [], 2);
I_seg = reshape(C(label, :),m,n,p);
figure
subplot(1, 2, 1), imshow(I, []), title('‘≠Õº')
subplot(1, 2, 2), imshow(uint8(I_seg), []), title('æ€¿‡Õº')
figure
plot(1:length(J), J, 'r-*'), xlabel('#iterations'), ylabel('objective function')