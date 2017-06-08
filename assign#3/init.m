function u = init(A,x,dx,imax,jmax)

%% plotting initial condition %%
u = zeros(imax,jmax);
for i = 1:imax
    u(i,1) = A*sin(dx*(i-1));
end
for j = 1:jmax
    u(1,j) = 0;
    u(imax,j) = 0;
end

figure(1)
plot(x,u(:,1),'r-o')
hold on

end