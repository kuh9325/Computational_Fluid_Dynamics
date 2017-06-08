%% using Point Successive Over-Relaxation method (PSOR): Jacobi

function PSOR_J(tmp,beta,tol,x,y,k,imax,jmax,kmax)

err = 1;                        % set initial error value
rp = input('Relexation parameter = ');
tic;
for k = 1:kmax
    ntmp = tmp;
    for j = 2:jmax-1
        for i = 2:imax-1
            ntmp(i,j) = (1-rp)*tmp(i,j) + (rp/(2*(1 + beta^2)))*(tmp(i+1,j)...
                + tmp(i-1,j) + (beta^2)*(tmp(i,j+1) + tmp(i,j-1)));
        end
    end
    err = sum(sum(abs(ntmp-tmp))) / (imax*jmax);
    iter(k) = k;
    Err(k) = err;
    tmp = ntmp;  
    fprintf('Iteration =%8.0f   -   Error =%10.6f \n',k,err)
    if err <= tol
        break
    end
end
t = toc;
T = tmp';

fprintf('\n@@ PSOR method: Jacobi @@\n')
fprintf('Number of iterations = \t %8.0f \nCalculation time =%12.0f sec \n',k,t)
Errtxt = fopen('PSOR:Jacobi.txt','w');
fprintf(Errtxt, '%d     %d \n', [iter; Err]);

contour(x,y,T,'Showtext','on')
grid on
xlabel('x');
ylabel('y');
title('using PSOR method: Jacobi');

end
