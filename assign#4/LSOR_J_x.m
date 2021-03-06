%% using Line Successive Over-Relaxation method (LSOR): Jacobi (x sweep)

function LSOR_J_x(tmp,beta,tol,x,y,k,imax,jmax,kmax)

err = 1;                        % set initial error value
rp = input('Relexation parameter = ');
KC = zeros(imax-2,imax-2);
KV = zeros(imax-2,1);
tic;
for k = 1:kmax
    ntmp = tmp;
    a = rp;
    b = rp;
    d = -2*(1+beta^2);
    for i = 1:imax-2
        for ii = 1:imax-2
            if i == ii
                KC(i,ii) = d;
            elseif i+1 == ii
                KC(i,ii) = a;
            elseif i-1 == ii
                KC(i,ii) = b;
            end
        end
    end
    for j = 2:jmax-1
        for i = 2:imax-1
            if i == 2
                KV(i-1) = - 2*(1 + beta^2)*(1-rp)*tmp(i,j) ...
                    -rp*beta^2*(tmp(i,j+1) + tmp(i,j-1)) -b*tmp(i-1,j);
            elseif i == imax-1
                KV(i-1) = - 2*(1 + beta^2)*(1-rp)*tmp(i,j) ...
                    -rp*beta^2*(tmp(i,j+1) + tmp(i,j-1)) -a*tmp(i+1,j);
            else
                KV(i-1) = - 2*(1 + beta^2)*(1-rp)*tmp(i,j) ...
                    -rp*beta^2*(tmp(i,j+1) + tmp(i,j-1));
            end
        end
        UK = KC\KV;
        for i = 2:imax-1
            ntmp(i,j) = UK(i-1);
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

fprintf('\n@@ LSOR method: Jacobi (x sweep) @@\n')
fprintf('Number of iterations = \t %8.0f \nCalculation time =%12.0f sec \n',k,t)
Errtxt = fopen('LSOR:Jacobi(x).txt','w');
fprintf(Errtxt, '%d     %d \n', [iter; Err]);

contour(x,y,T,'Showtext','on')
grid on
xlabel('x');
ylabel('y');
title('using LSOR method: Jacobi (x sweep)');

end