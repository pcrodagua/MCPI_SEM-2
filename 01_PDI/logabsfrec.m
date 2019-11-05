I = imread('test.jpg');
% I = rgb2gray(I);
imshow(I);
I = double(I);
Iff = fft2(I);
Iff = fftshift(Iff);
Ifm = log(abs(Iff));
% imagesc(Ifm);


Cxy = size(I);
[Cx,Cy] = size(I);
Cx = (Cx - 1)/2;
Cy = (Cy - 1)/2;

r = 10;
teta = 0:360/1000:360; %  intervalo de 0 - 360

x = round(r*cosd(teta) + Cx);
y = round(r*sind(teta) + Cy);

H = false(size(I));
for i=1:length(x)
  for j=1:length(y)  
    H(x(i),y(i)) = 1;
  end
end
H = imfill(H, 'holes');
mesh(H);
% imagesc(H);

% transformada inversa bidimensional

N = Iff.*H;
N = ifftshift(N);
N = ifft2(N);
N = abs(N);
imagesc(N);

