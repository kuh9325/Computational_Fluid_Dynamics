%% using Euler's FTFS method

function FTFS(x,u,cfl,imax,jmax)

for j = 1:jmax-1
    for i = 2:imax-1
        u(i,j+1) = u(i,j) - cfl*(u(i+1,j) - u(i,j));
    end
end

plot(x,u)

end