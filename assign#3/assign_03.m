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

%% exact solution
u1 = u;
for j = 1:jmax
    for i = 1:imax
        u1(i,j) = A*exp(-a*dt*(j-1))*sin(dx*(i-1));
    end
end

%% using Euler's FTCS method
u2 = u;
for j = 1:jmax-1
    for i = 2:imax-1
        u2(i,j+1) = u2(i,j) + cc*(u2(i+1,j) - 2*u2(i,j) + u2(i-1,j));
    end
end

%% using Richardson method
u3 = u;
for j = 2:jmax-1
    for i = 2:imax-1
        u3(i,2) = u3(i,1);
        u3(i,j+1) = u3(i,j-1) + 2*cc*(u3(i+1,j) -2*u3(i,j) + u3(i-1,j));
    end
end

%% using Dufort-Frankel method
u4 = u;
for i = 2:imax-1
    u4(i,2) = u2(i,2);
end
for j = 2:jmax-1
    for i = 2:imax-1
        u4(i,j+1) = ((1 - 2*cc)*u4(i,j-1) + 2*cc*(u4(i+1,j) + u4(i-1,j))) / (1 + 2*cc);
    end
end

%% using Laasonen method
u5 = u;
a5 = cc;
b5 = cc;
c5 = -u5;
d5 = -(1+2*cc);

KC5 = zeros(imax-2,imax-2);
for i = 1:imax-2
    for j = 1:imax-2
        if i == j
            KC5(i,j) = d5;
        elseif i+1 == j
            KC5(i,j) = a5;
        elseif i-1 == j
            KC5(i,j) = b5;
        else
            KC5(i,j) = 0;
        end
    end
end

KV5 = zeros(imax-2,imax-2);
for j = 1:jmax-1
    for i = 2:imax-1
        if i == 2
            KV5(i-1,j) = c5(i,j) - b5*u5(i-1,j+1);
        elseif i == imax-1
            KV5(i-1,j) = c5(i,j) - a5*u5(i+1,j+1);
        else
            KV5(i-1,j) = c5(i,j);
        end
    end

    UK5 = KC5\KV5;

    for i = 2:imax-1
        u5(i,j+1) = UK5(i-1,j);
        c5(i,j+1) = -u5(i,j+1);
    end
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

%% using Beta formulation
u7 = u;
beta = 1;
a7 = -beta*cc;
b7 = -beta*cc;
c7 = zeros(imax,jmax);
d7 = 1 + beta*2*cc;

KC7 = zeros(imax-2,imax-2);
for i = 1:imax-2
    for j = 1:imax-2
        if i == j
            KC7(i,j) = d7;
        elseif i+1 == j
            KC7(i,j) = a7;
        elseif i-1 == j
            KC7(i,j) = b7;
        else
            KC7(i,j) = 0;
        end
    end
end

KV7 = zeros(imax-2,imax-2);
for j = 1:jmax-1
    for i = 2:imax-1
        if i == 2
            KV7(i-1,j) = u7(i,j) + (1 - beta)*cc*(u7(i+1,j)...
                - 2*u7(i,j) + u7(i-1,j)) - b7*u7(i-1,j+1);
            elseif i == imax-1
            KV7(i-1,j) = u7(i,j) + (1 - beta)*cc*(u7(i+1,j)...
                - 2*u7(i,j) + u7(i-1,j)) - a7*u7(i+1,j+1);
        else
            KV7(i-1,j) = u7(i,j) + (1 - beta)*cc*(u7(i+1,j)...
                - 2*u7(i,j) + u7(i-1,j));
        end
    end
    
    UK7 = KC7\KV7;
    
    for i = 2:imax-1
        u7(i,j+1) = UK7(i-1,j);
        c7(i,j+1) = u7(i,j) + (1 - beta)*cc*(u7(i+1,j) - 2*u7(i,j) + u7(i-1,j));
    end
end

%% calculate error
error = zeros(imax,jmax);
for j = 1:jmax
    for i = 1:imax
        error(i,j) = u7(i,j) - u5(i,j);
    end
end

%% plotting
plot(x,u(:,1),'r-o')
hold on
%plot(x,u1,'c x')
%plot(x,u2,'g-x')
%plot(x,u3,'g-x')
plot(x,u4,'g-x')
%plot(x,u5,'g-x')
%plot(x,u6,'g-x')
%plot(x,u7,'g-x')
%plot(x,error)
xlim([0 pi])
ylim([0 1.2])
title('proof of \beta=0 eqauls to Laasonen method)')
legend('Absolute Error')