% https://ww2.mathworks.cn/help/images/ref/projective2d.html

Origin = imread('~/Downloads/StarZhou.jpeg'); 


theta = 10;

tm = [cosd(theta) -sind(theta) 0.0001;
      sind(theta) cosd(theta) 0.0005;
      0 0 1];

tform = projective2d(tm);

outputImage = imwarp(Origin, tform);

figure
subplot(1,2,1),imshow(uint8(Origin)),title('Origin Image')
subplot(1,2,2),imshow(uint8(outputImage)),title('Perspective Output')