%% using Dufort-Frankel method

function u = dufort_frankel(cc,x,u,imax,jmax)

for i = 2:imax-1
    u(i,2) = u(i,1) + cc*(u(i+1,1) - 2*u(i,1) + u(i-1,1));       % FTCS method
end
for j = 2:jmax-1
    for i = 2 : imax-1
       
        u(i,j+1) = ((1 - 2*cc)*u(i,j-1) + 2*cc*(u(i+1,j)...
            + u(i-1,j))) / (1 + 2*cc);
    end
end

figure(1)
plot(x,u,'g-x')

end