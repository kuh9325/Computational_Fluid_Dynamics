%% using Alternating Direction Implicit method (ADI): Jacobi (x -> y)

function ADI_J_xy(tmp,beta,tol,x,y,k,imax,jmax,kmax)

err = 1;                        % set initial error value
KC = zeros(imax-2,imax-2);
KV = zeros(imax-2,1);
nKC = zeros(jmax-2,jmax-2);
nKV = zeros(jmax-2,1);
tic;
for k = 1:kmax
    mtmp = tmp;       % 1/2 step 
    % for x sweep
    a = 1;
    b = 1;
    d = -2*(1 + beta^2);
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
                KV(i-1) = - beta^2*(tmp(i,j+1) + tmp(i,j-1))...
                    - b*tmp(i-1, j);
            elseif i == imax-1
                KV(i-1) = - beta^2*(tmp(i,j+1) + tmp(i,j-1))...
                    - a*tmp(i+1, j);
            else
                KV(i-1) = - beta^2*(tmp(i,j+1) + tmp(i,j-1));
            end
        end
        UK = KC\KV;
        for i = 2:imax-1
            mtmp(i,j) = UK(i-1);
        end
    end
    ntmp = mtmp;
    % for y sweep
    nb = beta^2;
    nd = -2*(1 + beta^2);
    na = beta^2;
    for j = 1:jmax-2
        for jj = 1:jmax-2
            if j == jj
                nKC(j,jj) = nd;
            elseif j+1 == jj
                nKC(j,jj) = na;
            elseif j-1 == jj
                nKC(j,jj) = nb;
            end
        end
    end
    for i = 2:imax-1
        for j = 2:jmax-1
            if j == 2
                nKV(j-1) = -mtmp(i+1,j) -mtmp(i-1,j)...
                    -nb*mtmp(i,j-1);
            elseif j == jmax-1
                nKV(j-1) = -mtmp(i+1,j) -mtmp(i-1,j)...
                    -na*mtmp(i,j+1);
            else
                nKV(j-1) = -mtmp(i+1,j) -mtmp(i-1,j);
            end
        end
        nUK = nKC\nKV;
        for j = 2:jmax-1
            ntmp(i,j) = nUK(j-1);
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

fprintf('\n@@ ADI method: Jacobi (x -> y) @@ \n')
fprintf('Number of iterations = \t %8.0f \nCalculation time =%12.0f sec \n',k,t)
Errtxt = fopen('ADI_Jacobi(x_y).txt','w');
fprintf(Errtxt, '%d     %d \n', [iter; Err]);

contour(x,y,T,'Showtext','on')
grid on
xlabel('x');
ylabel('y');
title('using ADI method: Jacobi (x -> y)');

end
