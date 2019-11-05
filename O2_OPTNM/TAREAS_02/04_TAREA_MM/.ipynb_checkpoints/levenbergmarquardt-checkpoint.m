%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATLAB code levenbergmarquardt.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% n_of_var -> number of design variables
% x = [-3 2] -> starting value of x
% lambda -> initially set to a large value
% epsilon1, epsilon2 -> constant used for terminating
% the algorithm
% delx -> required for gradient computation
% f_prev -> function value at first/previous iteration
% deriv -> gradient vector
% sec_deriv -> hessian matrix
% search -> search direction (vector)
%
clear all
clc
n_of_var = 2;
x = [- 3, 2];
lambda = 1e3;
epsilon1 = 1e-7;
epsilon2 = 1e-7;
delx = 1e-3;
f_prev = func_multivar(x);
fprintf('Initial function value = %7.4f\n ', f_prev)
fprintf(' No. x-vector f(x) Deriv \n')
fprintf('__________________________________________\n')
for i = 1:100
    f_prev = func_multivar(x);
    deriv = grad_vec(x, delx, n_of_var);
    sec_deriv = hessian(x, delx, n_of_var);
    search = - inv(sec_deriv + lambda * eye(length(x))) * deriv';
    x = x + search';
    f = func_multivar(x);
    if f < f_prev
        lambda = lambda / 2;
    else
        lambda = 2 * lambda;
    end
    if abs(f - f_prev) < epsilon1 || norm(deriv) < epsilon2
        break;
    end
    fprintf('%3d %8.3f %8.3f % 8.3f %8.3f \n', i, x, f, norm(deriv))
end
fprintf('__________________________________________\n')
