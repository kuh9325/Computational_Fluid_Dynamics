%% calculate error

function errcalc (x,ue,u2,imax,jmax,type)

error = zeros(imax,jmax);
for j = 1:jmax
    for i = 1:imax
        error(i,j) = u2(i,j) - ue(i,j);
    end
end

figure(2)
plot(x,error)
title('proof of \beta=0 eqauls to Laasonen method)')
legend('Absolute Error')

end