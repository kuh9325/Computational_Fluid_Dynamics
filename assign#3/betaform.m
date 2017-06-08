%% using Beta formulation

function u = betaform(cc,x,u,imax,jmax)

beta = 1;
a = -beta*cc;
b = -beta*cc;
c = zeros(imax,jmax);
d = 1 + beta*2*cc;

KC = zeros(imax-2,imax-2);
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

KV = zeros(imax-2,imax-2);
for j = 1:jmax-1
    for i = 2:imax-1
        if i == 2
            KV(i-1,j) = u(i,j) + (1-beta)*cc*(u(i+1,j) -2*u(i,j) + u(i-1,j))...
                -b*u(i-1,j+1);
            elseif i == imax-1
            KV(i-1,j) = u(i,j) + (1-beta)*cc*(u(i+1,j) -2*u(i,j) + u(i-1,j))...
                -a*u(i+1,j+1);
        else
            KV(i-1,j) = u(i,j) + (1-beta)*cc*(u(i+1,j) -2*u(i,j) + u(i-1,j));
        end
    end
    
    UK = KC\KV;
    
    for i = 2:imax-1
        u(i,j+1) = UK(i-1,j);
        c(i,j+1) = u(i,j) + (1-beta)*cc*(u(i+1,j) -2*u(i,j) + u(i-1,j));
    end
end

figure(1)
plot(x,u,'g-x')

end