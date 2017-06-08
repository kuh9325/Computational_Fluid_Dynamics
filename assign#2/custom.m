function custom(x,u,cfl,imax,jmax)

for j = 1:jmax-1
    for i = 2:imax-1
        if j == 1
                u(i,j+1) = u(i,j) - cfl*(u(i,j) - u(i-1,j));        % upwind method
        else
            u(i,j+1) = -1*u(i,j-1) +2*u(i,j) -1*(cfl*dt/dx)*(u(i+1,j)...
                -2*u(i,j) + u(i-1,j));
        end
    end
end

plot(x,u)

end