clear all, clc

jmax = 10;
cfl = 0.3;
a = 340;
dx = 0.02;
dt = cfl*dx/a;
xmax = 5;
imax = (xmax/dx)+1;
jmax = jmax+1;

x = 0:dx:xmax; 
frontx = sum(x<=1);
midx = sum(x<=2);
rearx = sum(x<=3);

%% plotting waveform %%
u = init(x,imax,jmax);
% plot(x,u(:,1))
%% using Euler's FTFS method
% FTFS(x,u,cfl,imax,jmax);

%% using Euler's FTCS method
% FTCS(x,u,cfl,imax,jmax);

%% using Lax method
% Lax(x,u,cfl,imax,jmax);

%% using The 1st-order upwind differencing method
% first_upwind(x,u,cfl,imax,jmax);

%% using midpoint leapfrog method
% midpoint_leapfrog(x,u,cfl,imax,jmax);

%% using Euler's BTCS method
% BTCS(x,u,cfl,imax,jmax);

%% using Crank-Nicolson method
% crank_nicolson(x,u,cfl,imax,jmax);

%% using custom method
custom(x,u,cfl,imax,jmax);

%% plotting

xlim([0 3.5])
ylim([0 11])