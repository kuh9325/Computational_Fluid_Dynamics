%% using Euler's FTCS method

function u = FTCS(cc,x,u,imax,jmax)

for j = 1:jmax-1
    for i = 2:imax-1
        u(i,j+1) = u(i,j) + cc*(u(i+1,j) - 2*u(i,j) + u(i-1,j));
    end
end

figure(1)
plot(x,u,'g-x')

end