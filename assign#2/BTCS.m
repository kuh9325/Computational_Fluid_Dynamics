%% using Euler's BTCS method

function BTCS(x,u,cfl,imax,jmax)

a = -cfl/2;
b = cfl/2;
c = -u;
d = -1;

KC = zeros(imax-2,jmax-2);
for i = 1:imax-2
    for j = 1:imax-2
        if i == j
            KC(i,j) = d;
        elseif i+1 == j
            KC(i,j) = a;
        elseif i-1 == j
            KC(i,j) = b;
        else
            KC(i,j) = 0;
        end
    end
end

KV = zeros(imax-2,jmax-1);
for j = 1:jmax-1
    for i = 2:imax-1
        if i == 2
            KV(i-1,j) = c(i,j) - b*u(i-1,j+1);
        elseif i == imax-1
            KV(i-1,j) = c(i,j) - a*u(i+1,j+1);
        else
            KV(i-1,j) = c(i,j);
        end
    end
    
    UK = KC\KV;
    
    for i = 2:imax-1
        u(i,j+1) = UK(i-1,j);
        c(i,j+1) = -u(i,j+1);
    end
end

plot(x,u)

end
