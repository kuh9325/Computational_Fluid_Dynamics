clear all, clc
a = 2;
xmax = pi;
tmax = 1;
imax = 25;
jmax = 50;
dx = xmax/(imax-1);
dt = tmax/(jmax-1);
cc = a*dt/(dx)^2;

x = 0:dx:xmax;

%% plotting initial condition
u = zeros(imax,jmax);
for i = 1:imax
    A = 1;
    u(i,1) = A*sin(dx*(i-1));
end
for j = 1:jmax
    u(1,j) = 0;
    u(imax,j) = 0;
end

%% using Crank-Nicolson method
u6 = u;
a6 = -cc/2;
b6 = -cc/2;
c6 = zeros(imax,jmax);
d6 = 1 + cc;

KC6 = zeros(imax-2,imax-2);
for i = 1:imax-2
    for j = 1:imax-2
        if i == j
            KC6(i,j) = d6;
        elseif i+1 == j
             KC6(i,j) = a6;
        elseif i-1 == j
            KC6(i,j) = b6;
        else
            KC6(i,j) = 0;
        end
    end
end

KV6 = zeros(imax-2,imax-2);
for j = 1:jmax-1
    for i = 2:imax-1
        if i == 2
            KV6(i-1,j) = u6(i,j) + (cc/2)*(u6(i+1,j)...
                - 2*u6(i,j) + u6(i-1,j)) - b6*u6(i-1,j+1);
        elseif i == imax-1
            KV6(i-1,j) = u6(i,j) + (cc/2)*(u6(i+1,j)...
                - 2*u6(i,j) + u6(i-1,j)) - a6*u6(i+1,j+1);
        else
            KV6(i-1,j) = u6(i,j) + (cc/2)*(u6(i+1,j)...
                - 2*u6(i,j) + u6(i-1,j));
        end
    end

    UK6 = KC6\KV6;
  
    for i = 2:imax-1
        u6(i,j+1) = UK6(i-1,j);
        c6(i,j+1) = u6(i,j) + (cc/2)*(u6(i+1,j) - 2*u6(i,j) + u6(i-1,j));
    end
end

plot(x,u6,'g-x')