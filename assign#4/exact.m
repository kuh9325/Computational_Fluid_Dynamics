%% exact solution
function exact(x,y,imax,jmax,L,H)

syms n
iter = 0;
t1 = 100;
tic;
for j = 1:jmax
   for i = 1:imax
       iter = iter + 1;
       c1 = (1-(-1)^n)/(n*pi);
       c2 = (sinh(n*pi*(H-y(j))/L))/(sinh(n*pi*H/L));
       c3 = sin(n*pi*x(i)/L);
       ntmp(i,j) = double(2*t1*symsum(c1*c2*c3,n,1,50));
   end   
end
t = toc;
T = ntmp';

fprintf('\n@@ analytical exact solution @@\n')
fprintf('Number of iterations = \t %8.0f \nCalculation time =%12.0f sec \n',iter,t)
txt = fopen('exact.txt','w');
fprintf(Errtxt, '%d     %d \n', [iter; t]);

contour(x,y,T,'Showtext','on')
grid on
xlabel('x');
ylabel('y');
title('Exact solution for fixed wall temp.');

end