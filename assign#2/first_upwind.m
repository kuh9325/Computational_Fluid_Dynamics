%% using The 1st-order upwind differencing method

function first_upwind(x,u,cfl,imax,jmax)

for j = 1:jmax-1
    for i = 2:imax
        u(i,j+1) = u(i,j) - cfl*(u(i,j) - u(i-1,j));
    end
end

plot(x,u)

end