%% using Line Successive Over-Relaxation method (LSOR): Jacobi (y sweep)

function LSOR_J_y(tmp,beta,tol,x,y,k,imax,jmax,kmax)

err = 1;                        % set initial error value
rp = input('Relexation parameter = ');
KC = zeros(jmax-2,jmax-2);
KV = zeros(jmax-2,1);
tic;
for k = 1:kmax
    ntmp = tmp;
    a = rp*beta^2;
    b = rp*beta^2;
    d = -2*(1+beta^2);
    for j = 1:jmax-2
        for jj = 1:jmax-2
            if j == jj
                KC(j,jj) = d;
            elseif j+1 == jj
                KC(j,jj) = a;
            elseif j-1 == jj
                KC(j,jj) = b;
            end
        end
    end  
    for i = 2:imax-1
        for j = 2:jmax-1
            if j == 2
                KV(j-1) = -2*(1 + beta^2)*(1-rp)*tmp(i,j) ...
                    -rp*(tmp(i+1,j) + tmp(i-1,j)) -b*tmp(i,j-1);
            elseif j == jmax - 1
                KV(j-1) = - 2*(1 + beta^2)*(1-rp)*tmp(i,j)...
                    -rp*(tmp(i+1,j) + tmp(i-1,j)) -a*tmp(i,j+1);
            else
                KV(j-1) = - 2*(1 + beta^2)*(1-rp)*tmp(i,j)...
                    -rp*(tmp(i+1,j) + tmp(i-1,j));
            end
        end
        UK = KC\KV;
        for j = 2:jmax-1
            ntmp(i,j) = UK(j-1);
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

fprintf('\n@@ LSOR method: Jacobi (y sweep) @@\n')
fprintf('Number of iterations = \t %8.0f \nCalculation time =%12.0f sec \n',k,t)
Errtxt = fopen('LSOR:Jacobi(y).txt','w');
fprintf(Errtxt, '%d     %d \n', [iter; Err]);

contour(x,y,T,'Showtext','on')
grid on
xlabel('x');
ylabel('y');
title('using LSOR method: Jacobi (y sweep)');

end
