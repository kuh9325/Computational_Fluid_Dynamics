clear all, clc
L = 1;
H = 2;
 
dx = 0.02;
dy = 0.02;
beta = dx/dy;
imax = fix(L/dx)+1;             % using integer value
jmax = fix(H/dy)+1;
x = 0:dx:L;
y = 0:dy:H;
tol = 0.0001;                   % tolerance
kmax = 5000;                    % maximum number of iteration
k = 0;                          % initial iteration

%% plotting initial condition
tmp = zeros(imax,jmax);
tmp(:,1) = 100;
tmp(:,jmax) = 0;
tmp(1,:) = 0;
tmp(imax, :) = 0;


%% plotting exact solution
% exact(x,y,imax,jmax,L,H);

%% using Point Jacobi iteration method
% PJi(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using Point Gauss-Seidel iteration method
% PGSi(tmp,beta,tol,x,y,k,imax,jmax,kmax)

%% using Line Jacobi iteration method (x sweep)
% LJi_x(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using Line Jacobi iteration method (y sweep)
% LJi_y(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using Line Gauss-Seidel iteration method (x sweep)
% LGSi_x(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using Line Gauss-Seidel iteration method (y sweep)
% LGSi_y(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using Point Successive Over-Relaxation method (PSOR): Jacobi
% PSOR_J(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using Point Successive Over-Relaxation method (PSOR): Gauss-Seidel
% PSOR_GS(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using Line Successive Over-Relaxation method (LSOR): Jacobi (x sweep)
% LSOR_J_x(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using Line Successive Over-Relaxation method (LSOR): Jacobi (y sweep)
% LSOR_J_y(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using Line Successive Over-Relaxation method (LSOR): Gauss-Seidel (x sweep)
% LSOR_GS_x(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using Line Successive Over-Relaxation method (LSOR): Gauss - y sweep
% LSOR_GS_y(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using Alternating Direction Implicit method (ADI): Jacobi (x -> y)
% ADI_J_xy(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using Alternating Direction Implicit method (ADI): Jacobi (y -> x)
% ADI_J_yx(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using ADI Over-Relaxation method: Jacobi (x -> y)
ADIOR_J_xy(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using ADI Over-Relaxation method: Jacobi (y -> x)
% ADIOR_J_yx(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using Alternating Direction Implicit method (ADI): Gauss-Seidel (x -> y)
% ADI_GS_xy(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using Alternating Direction Implicit method (ADI): Gauss-Seidel (y -> x)
% ADI_GS_yx(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using ADI Over-Relaxation method: Gauss-Seidel (x -> y)
% ADIOR_GS_xy(tmp,beta,tol,x,y,k,imax,jmax,kmax);

%% using ADI Over-Relaxation method: Gauss-Seidel (y -> x)
ADIOR_GS_yx(tmp,beta,tol,x,y,k,imax,jmax,kmax);