I = imread('gaussian3x3.jpg');
% I = rgb2gray(I);
I = double(I);
Cxy = size(I);
[Cx_,Cy_] = size(I);

Cx = (Cx_ - 1)/2;
Cy = (Cy_ - 1)/2;

sigma = 2;

H = zeros(size(I));

for i=1:length(Cx_)
  for j=1:length(Cy_)  
    H(i, j) = exp(- 0.5* ((i - Cx)^2 + (j - Cy)^2) /sigma^2    );
  end
end
mesh(H);
shading interp;
