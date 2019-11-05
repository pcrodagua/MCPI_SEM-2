clear
close all
% pkg load image imfreehand
[filename,path]=uigetfile(['.png;.tif;.jpg;.gif,All Image Files']);
I = imread([path,filename]);
%bote = imread('C:\Users\HeavyRain350\Desktop\academico\MCPI\2ndo Semestre\PDI\bote.jpg');

%linspace(0,255,7)
%I=rgb2gray(I);
[x,y,~]=size(I);
fx = zeros(256,3);
k = 5;
med = zeros(k,3);
cova = zeros(3,3,k);
figure, imshow (I);
I = double(I);
for i=1:k
    h=imfreehand;
    p=wait(h);
    BW = poly2mask(p(:,1),p(:,2),x,y);
    indi = find(BW==1);
    p=round(p);
    var=I(indi);
    var(:,2)=I(indi+(y*x));
    var(:,3)=I(indi+(2*y*x));
    med(i,:)=mean(var);
    cova(:,:,i)=cov([var(:,1),var(:,2),var(:,3)]);
end
I=double(I);
phi=ones(1,k)/k;
Ir=I(:,:,1);
Ir = Ir(:);
Ig=I(:,:,2);
Ig = Ig(:);
Ib=I(:,:,3);
Ib = Ib(:);
N=length(Ir);
gamma=zeros(N,k);
color = lines(k+2);
for iter=1:10
  %  for i=1:N
       suma=0;

       for j=1:k
           suma = suma + phi(j)*mvnpdf([Ir(:),Ig(:),Ib(:)],med(j,:),cova(:,:,j));
       end

       for j=1:k
           gamma(:,j) =(phi(j)*mvnpdf([Ir(:),Ig(:),Ib(:)],med(j,:),cova(:,:,j)))./suma;
       end
  %  end

    for j=1:k
        suma=sum(gamma(:,j));
        phi(j)=suma/N;
        med(j,1)=dot(gamma(:,j),Ir(:))/suma;
        med(j,2)=dot(gamma(:,j),Ig(:))/suma;
        med(j,3)=dot(gamma(:,j),Ib(:))/suma;
        [~,labels]=max(gamma,[],2);
        indi= find(labels==i);
        cova(:,:,i)=cov([Ir(indi),Ig(indi),Ib(indi)]);
%         cova(1,1,i)= sqrt(dot(gamma(:,j),(Ir(:)-med(j,1)).^2)/suma);
%         cova(2,2,i)= sqrt(dot(gamma(:,j),(Ig(:)-med(j,2)).^2)/suma);
%         cova(3,3,i)= sqrt(dot(gamma(:,j),(Ib(:)-med(j,3)).^2)/suma);
%         cova(1,2,i)= sqrt(dot(gamma(:,j),(Ir(:)-med(j,1).*(Ig(:)-med(j,2))))/suma);
%         cova(1,3,i)= sqrt(dot(gamma(:,j),(Ir(:)-med(j,1).*(Ib(:)-med(j,3))))/suma);
%         cova(2,1,i)= cova(1,2,i);
%         cova(2,3,i)= sqrt(dot(gamma(:,j),(Ig(:)-med(j,2).*(Ib(:)-med(j,3))))/suma);
%         cova(3,1,i)= cova(1,3,i);
%         cova(3,2,i)= cova(2,3,i);
    end
    [~,labels]=max(gamma,[],2);
    labels= reshape(labels,[x,y]);
    mask = zeros(x,y,1,k+1);
    for i = 1:k
       temp = (labels==i);
       mask (:,:,1,i)=uint8(temp*255);
    end
    montage(uint8(mask));
end