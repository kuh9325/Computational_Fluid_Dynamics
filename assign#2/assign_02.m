clear all, clc

step = 5;
cfl = 1;
a = 340;
dx = 0.5;
dt = cfl*dx/a;
xmax = 10;
imax = (xmax/dx)+1;
jmax = step+1;

x = 0:dx:xmax; 
frontx = sum(x<=1);
midx = sum(x<=2);
rearx = sum(x<=3);

%% plotting waveform %%
u=zeros(imax,jmax);
for i = 1:imax
    if i < 0
        u(i,1) = 0;
    elseif i <= frontx
        u(i,1) = 10*x(i);
    elseif i <= midx && i > frontx
        u(i,1) = 10;
    elseif i <= rearx && i > midx
        u(i,1) = -10*x(i)+30;
    else
        u(i,1) = 0;  
    end
end

%% using Euler's FTFS method
u1=u;
for j = 1:step
    for i = 2:imax-1
        u1(i,j+1) = u1(i,j) - cfl*(u1(i+1,j) - u1(i,j));
    end
end

%% using Euler's FTCS method
u2=u;
for j = 1:step
    for i = 2:imax-1
        u2(i,j+1) = u2(i,j) - (cfl/2)*(u2(i+1,j)- u2(i-1,j));
    end
end

%% using Lax method
u3=u;
for j = 1:step
    for i = 2:imax-1
        u3(i,j+1) = (1/2)*(u3(i+1,j)+u3(i-1,j))...
        - (cfl/2)*(u3(i+1,j) - u3(i-1,j));
    end
end

%% using The 1st-order upwind differencing method
u4=u;
for j = 1:step
    for i = 2:imax
        u4(i,j+1) = u4(i,j) - cfl*(u4(i,j) - u4(i-1,j));
    end
end

%% using midpoint leapfrog method
u5=u;
for j = 2:step
    u5(:,2) = u5(:,1);
    for i = 2:imax-1
        u5(i,j+1) = u5(i,j-1) - cfl*(u5(i+1,j) - u5(i-1,j));
    end
end

%% using Euler's BTCS method
u6=u;
a6 = -cfl/2;
b6 = cfl/2;
c6 = -u6;
d6 = -1;

A6 = zeros(imax-2,step-1);
for i = 1:imax-2
    for j = 1:imax-2
        if i == j
            A6(i,j) = d6;
        elseif i+1 == j
            A6(i,j) = a6;
        elseif i-1 == j
            A6(i,j) = b6;
        else
            A6(i,j) = 0;
        end
    end
end

C6 = zeros(imax-2,step);
for j = 1:step
    for i = 2:imax-1
        if i == 2
            C6(i-1,j) = c6(i,j) - b6*u6(i-1,j+1);
        elseif i == imax-1
            C6(i-1,j) = c6(i,j) - a6*u6(i+1,j+1);
        else
            C6(i-1,j) = c6(i,j);
        end
    end
    
    U = A6\C6;
    
    for i = 2:imax-1
        u6(i,j+1) = U(i-1,j);
        c6(i,j+1) = -u6(i,j+1);
    end
end

%% using Crank-Nicolson method
u7=u;
a7 = cfl/4;
b7 = -cfl/4;
d7 = 1;

A7 = zeros(imax-2,step-1);
for i = 1:imax-2
    for j = 1:imax-2
        if i == j
            A7(i,j) = d7;
        elseif i+1 == j
            A7(i,j) = a7;
        elseif i-1 == j
            A7(i,j) = b7;
        else
            A7(i,j) = 0;
        end
    end
end

C7 = zeros(imax-2,step);
for j = 1:step
    for i = 2:imax-1
        if i == 2
            C7(i-1,j) = u7(i,j) + b7*(u7(i+1,j)...
                - u7(i-1,j)) - b7*u7(i-1,j+1);
        elseif i == imax-1
            C7(i-1,j) = u7(i,j) + b7*(u7(i+1,j)...
                - u7(i-1,j)) - a7*u7(i+1,j+1);
        else
            C7(i-1,j) = u7(i,j) + b7*(u7(i+1,j) - u7(i-1,j));
        end
    end
    
    U7 = A7\C7;
    
    for i = 2:imax-1
        u7(i,j+1) = U7(i-1,j);
        c6(i,j+1) = u7(i,j+1) + b6*(u7(i+1,j+1) - u7(i-1,j+1));
    end
 
end

plot(x,u(:,1))
%plot(x,u1)
%plot(x,u2)
%plot(x,u3)
%plot(x,u4)
%plot(x,u5)
%plot(x,u6)
%plot(x,u7)
xlim([0 10])
ylim([0 11])