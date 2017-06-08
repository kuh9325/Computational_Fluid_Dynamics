%% using Euler's FTCS method

function FTCS(x,u,cfl,imax,jmax)

for j = 1:jmax-1
    for i = 2:imax-1
        u(i,j+1) = u(i,j) - (cfl/2)*(u(i+1,j)- u(i-1,j));
    end
end

plot(x,u)

end