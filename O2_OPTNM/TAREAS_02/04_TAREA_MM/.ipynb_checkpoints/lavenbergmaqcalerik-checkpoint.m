
global ep1;
ep1=1e-3; 

global Dx;
Dx=1e-4;

U = @(x)  100*(sqrt(x(1).^2  + (x(2)+1).^2) -1).^2 +   90*(sqrt(x(1).^2  + (x(2)+1).^2) -1).^2 - (20.*x(1) + 40.*x(2));
xi = [-1 1];
lambda = 1;
matrixI = eye(length(xi));
xsig = xi;
aprox = xi;
iter = 0;
while 1==1
    iter = iter+1;
    grad = calcularGradiente(U,xi);
    hess = calcularHessiana(U,xi);
    fxi = U(xi);
    Si = -(grad/(hess + lambda*matrixI));
    xsig = xi+Si;
    fxsig = U(xsig);
    fprintf('%3d |%8.3f %8.3f| % 8.3f %8.3f %8.3f\n',iter,xi,fxi,norm(grad),lambda)
    if(fxsig < fxi)
        lambda = lambda/2;
    else
        lambda = lambda*2;
    end
    
    if(abs(fxsig - fxi)<ep1 || norm(grad)< ep1)
        aprox = xsig;
        break
    else
        xi = xsig;
    end
end

fprintf("\nNúmero de iteraciones: %d\n",iter);
fprintf("Valor aproximado x_1: %3.6f, Valor aproximado x_2: %3.6f\n",aprox(1),aprox(2));
fprintf("Valor mínimo de la función: %5.6f\n\n",U(aprox));

function [hess] = calcularHessiana(f,xk)
    global Dx;
    hess = zeros(length(xk),length(xk));
    for i = 1:length(xk)
        for j = 1:length(xk)
            if(i==j)
                hess(i,j)=(f(sumarDel(xk,Dx,i))-2*f(xk)+f(sumarDel(xk,-Dx,i)))/Dx^2;
            else
                hess(i,j)=(f(sumarDel(sumarDel(xk,Dx,i),Dx,j)) -f(sumarDel(sumarDel(xk,Dx,i),-Dx,j)) -f(sumarDel(sumarDel(xk,-Dx,i),Dx,j)) +f(sumarDel(sumarDel(xk,-Dx,i),-Dx,j)))/(4*Dx^2);
            end
        end
    end
end

function [grad] = calcularGradiente(f,xk)
    Dx=1e-4;
    grad = xk;
    for i = 1:length(xk)
        grad(i)=(f(sumarDel(xk,Dx,i))-f(xk))/Dx;
    end
end

function [xk] = sumarDel(xk,Dx,i)
    xk(i)=xk(i)+Dx;
end