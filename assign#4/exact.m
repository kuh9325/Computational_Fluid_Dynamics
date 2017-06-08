%% exact solution
function exact(x,y,imax,jmax,L,H)

syms n
t = 100;
iter = 0;
t = zeros(imax,jmax);
for j = 1:jmax
   for i = 1:imax
       iter = iter + 1              % counting iteration step on real-time
       c1 = (1-(-1)^n)/(n*pi);
       c2 = (sinh(n*pi*(H-y(j))/L))/(sinh(n*pi*H/L));
       c3 = sin(n*pi*x(i)/L);
       t(i,j) = double(2*t*symsum(c1*c2*c3,n,1,50));
   end   
end
T = t';
contour(x,y,T,'Showtext','on')
grid on
xlabel('x');
ylabel('y');
title('Exact solution for fixed wall temp.');

end