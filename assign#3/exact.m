%% exact solution

function u = exact(A,a,x,u,dx,dt,imax,jmax)

for j = 1:jmax
    for i = 1:imax
        u(i,j) = A*exp(-a*dt*(j-1))*sin(dx*(i-1));
    end
end

figure(2)
plot(x,u,'c x')

end