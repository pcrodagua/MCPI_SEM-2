%Codigo 23 de Octubre del 2019
clear all
close all

[filename, path] = uigetfile({'*.jpg;*.tif;*,png;*.gif','All Image Files';...
    '*.*','All Files'});

I=imread([path,filename]);

[x, y, ~] = size(I);
fx = zeros(256,3);
figure, hold on
color = [1 0 0];
color(2,:) = [0 1 0];
color(3,:) = [0 1 0];
for i = 1:3
    [fx(:,i),x] = imhist(squeeze(I(:,:,i)));
    fx(:,i)=fx(:,i)/sum(fx(:,i));
    plot(xt,fx(:,i),'color',color(i,:))
end

k=7;


%%%%%Hasta aqui todo chido machin y perron :v 
lim1 = ((max(I(:)) - min(I(:)))/4) + min(I(:));
lim2  = max(I(:)) - ((max(I(:)) - min(I(:)))/4);
m = linspace(lim1,lim2,k);
sgm = ones(1,k)*5;
phi = ones(1,k)/k;
Iv = I(:);
N = length(Iv);
gamma = zeros(N,k);
color = lines(k+1);

for j = 1:k
    plot(x,phi(j)*normpdf(x,m(j),sgm(j)),'Color',color(j,:))
end

hold off

for iter = 1:20
    for i = 1:N
        suma=0;
        for j=1:k
            suma=suma+phi(j)*normpdf(Iv(i),m(j),sgm(j));
        end
        for j=1:k
            gamma(i,j)=(phi(j)*normpdf(Iv(i),m(j),sgm(j)))/suma;
        end
    end
    for j=1:k
        suma=sum(gamma(:,j));
        phi(j)=suma/N;
        m(j)=dot(gamma(:,j),Iv(:))/suma;
        sgm(j)=sqrt(dot(gamma(:,j),(Iv(:)-m(j)).^2)/suma);
    end
    
    plot(x,fx)
    hold on
    for j=1:k
        plot(x,phi(j)*normpdf(x,m(j),sgm(j)),'Color',color(j+1,:))
    end
    title(num2str(phi))
    hold off
    drawnow
end