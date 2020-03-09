clc;
close all;
I = imread('~/Downloads/BSDS/images/train/24063.jpg');
[m, n, p] = size(I);
k = 19;
%�����������ѡ��ʡ�Ե���������
[C, label, J] = kmeans(I, k);
%�ָ�
I_seg = reshape(C(label, :), m, n, p);
figure
subplot(1, 2, 1), imshow(I, []), title('ԭͼ')
subplot(1, 2, 2), imshow(uint8(I_seg), []), title('����ͼ')
figure
%����Ŀ�꺯��ͼ��
plot(1:length(J), J, 'r-*'), xlabel('#iterations'), ylabel('Objective function')