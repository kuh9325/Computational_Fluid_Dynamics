clear all, clc
a = 2;
A = 1;
xmax = pi;
tmax = 1;
imax = 25;
jmax = 50;
dx = xmax/(imax-1);
dt = tmax/(jmax-1);
cc = a*dt/(dx)^2;

x = 0:dx:xmax;

%% plotting initial condition
u = init(A,x,dx,imax,jmax);

%% exact solution
ue = exact(A,a,x,u,dx,dt,imax,jmax);

%% using Euler's FTCS method
% u2 = FTCS(cc,x,u,imax,jmax)

%% using Richardson method
% u2 = richardson(cc,x,u,imax,jmax)

%% using Dufort-Frankel method
% u2 = dufort_frankel(cc,x,u,imax,jmax)

%% using Laasonen method
% u2 = laasonen(cc,x,u,imax,jmax);

%% using Crank-Nicolson method
% u2 = crank_nicolson(cc,x,u,imax,jmax);

%% using Beta formulation
u2 = betaform(cc,x,u,imax,jmax);

%% calculate error
errcalc (x,ue,u2,imax,jmax,type);

%% plotting

figure(1)
xlim([0 pi])
ylim([0 1.2])
