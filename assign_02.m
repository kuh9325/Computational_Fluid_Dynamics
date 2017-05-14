clear all, clc
step = 5;
cfl = 1;
a6 = 340;
dx = 0.02;
dt = cfl*dx/a6;
xmax = 10;
tmax = dt*step;
fnx = xmax/dx;
fny = tmax/dt;
imax = fnx+1;
jmax = fny+1;
z = zeros(imax,jmax); % for plane graph

x = 0:dx:xmax; 
frontx = sum(x<=1);
midx = sum(x<=2);
rearx = sum(x<=3);

%% plotting waveform %%
u=zeros(imax,jmax);
for i = 1:imax
    if i <= frontx
        u(i,1) = 10*x(i);
    elseif i < midx && i > frontx
        u(i,1) = 10;
    elseif i <= rearx && i >= midx
        u(i,1) = -10*x(i)+30;
    else
        u(i,1) = 0;  
    end
end

%% using Euler's FTFS method
u1=u;
for j = 1:fny
    for i = 2:fnx
        u1(i,j+1) = u1(i,j) - cfl*(u1(i+1,j) - u1(i,j));
    end
end

%% using Euler's FTCS method
u2=u;
for j = 1:fny
    for i = 2:fnx
        u2(i,j+1) = u2(i,j) - (cfl/2)*(u2(i+1,j) - u2(i-1,j));
    end
end

%% using Lax method
u3=u;
for j = 1:fny
    for i = 2:fnx
        u3(i,j+1) = (1/2)*(u3(i+1,j)+u3(i-1,j)) - (cfl/2)*(u3(i+1,j) - u3(i-1,j));
    end
end

%% using The 1st-order upwind differencing method %
u4=u;
for j = 1:fny
    for i = 2:imax
        u4(i,j+1) = u4(i,j) - cfl*(u4(i,j) - u4(i-1,j));
    end
end

%% using midpoint leapfrog method
u5=u;
for j = 2:fny
    u5(:,2) = u5(:,1);
    for i = 2:fnx
        u5(i,j+1) = u5(i,j-1) - cfl*(u5(i+1,j) - u5(i-1,j));
    end
end

%% using Euler's BTCS method
u6=u;
a6 = -cfl/2;
b6 = cfl/2;
c6 = -u6;
d6 = -1;

atmp6 = zeros(fnx-1,fny-1);
for i = 1:fnx-1
    for j = 1:fnx-1
        if i == j
            atmp6(i,j) = d6;
        elseif i+1 == j
            atmp6(i,j) = a6;
        elseif i-1 == j
            atmp6(i,j) = b6;
        else
            atmp6(i,j) = 0;
        end
    end
end

ctmp6 = zeros(fnx-1,fny);
for j = 1:fny
    for i = 2:fnx
        if i == 2
            ctmp6(i-1,j) = c6(i,j) - b6*u6(i-1,j+1);
        elseif i == imax-1
            ctmp6(i-1,j) = c6(i,j) - a6*u6(i+1,j+1);
        else
            ctmp6(i-1,j) = c6(i,j);
        end
    end
    
    utmp = atmp6\ctmp6;
    
    for i = 2:fnx
        u6(i,j+1) = utmp(i-1,j);
        c6(i,j+1) = -u6(i,j+1);
    end
end

%% using Crank-Nicolson method
u7=u;
a7 = cfl/4;
b7 = -cfl/4;
d7 = 1;

atmp7 = zeros(fnx-1,fny-1);
for i = 1:fnx-1
    for j = 1:fnx-1
        if i == j
            atmp7(i,j) = d7;
        elseif i+1 == j
            atmp7(i,j) = a7;
        elseif i-1 == j
            atmp7(i,j) = b7;
        else
            atmp7(i,j) = 0;
        end
    end
end

ctmp7 = zeros(fnx-1,fny);
for j = 1:fny
    for i = 2:fnx
        if i == 2
            ctmp7(i-1,j) = u7(i,j) + b7*(u7(i+1,j) - u7(i-1,j)) - b7*u7(i-1,j+1);
        elseif i == imax-1
            ctmp7(i-1,j) = u7(i,j) + b7*(u7(i+1,j) - u7(i-1,j)) - a7*u7(i+1,j+1);
        else
            ctmp7(i-1,j) = u7(i,j) + b7*(u7(i+1,j) - u7(i-1,j));
        end
    end
    
    utmp7 = atmp7\ctmp7;
    
    for i = 2:fnx
        u7(i,j+1) = utmp7(i-1,j);
        c6(i,j+1) = u7(i,j+1) + b6*(u7(i+1,j+1) - u7(i-1,j+1));
    end
 
end

plot(u)
hold on
%plot(u1)
%plot(u2)
%plot(u3)
%plot(u4)
%plot(u5)
%plot(u6)
%plot(u7)
