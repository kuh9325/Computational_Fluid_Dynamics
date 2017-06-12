clear all, clc

tmp = [16 26 36 46 56 66 76;15 25 35 45 55 65 75;14 24 34 44 54 64 74;...
    13 23 33 43 53 63 73;12 22 32 42 52 62 72;11 21 31 41 51 61 71];
beta = 3;
imax = 6;
jmax = 7;

sM = (imax-2)*(jmax-2); % size of matrix

KC = zeros(sM);
KV = zeros(sM,1);
a = 1;
b = 1;
c = beta;
d = -2*(1+beta^2);
tic;

ntmp = tmp;       % 1/2 step 
for i = 1:sM
    for j = 1:sM
        if i == j
            KC(i,j) = d;
        elseif i+1 == j
            KC(i,j) = a;
        elseif i-1 == j
            KC(i,j) = b;
        elseif i+(imax-2) == j
            KC(i,j) = c^2;
        elseif i-(imax-2) == j
            KC(i,j) = c^2;
        end
    end
end

for i = 1:sM-1
    if mod(i,imax-2) == 0
        KC(i+1,i) = 0;
        KC(i,i+1) = 0;
    end
end

for j = 1:jmax-2
    j
    for i = 1:imax-2
        i
        index = (imax-2)*(j-1)+(i)
        if j == 1 
            if mod(i,(imax-2)) == 1
                KV(index) = -ntmp(1,2)-(c^2)*ntmp(2,1)
            elseif mod((imax-2),i) == 0
                KV(index) = -ntmp(imax,2)-(c^2)*ntmp(imax-1,1)
            else
                KV(index) = -(c^2)*ntmp(i+1,1)
            end
        elseif j == jmax-2
            if mod(i,(imax-2)) == 1
                KV(index) = -ntmp(1,jmax-1)-(c^2)*ntmp(2,jmax)
            elseif mod(i,(imax-2)) == 0
                KV(index) = -ntmp(imax,jmax-1)-(c^2)*ntmp(imax-1,jmax)
            else
                KV(index) = -(c^2)*ntmp(i+1,jmax)
            end
        elseif mod(i,(imax-2)) == 1
            KV(index) = -ntmp(1,j+1)
        elseif mod(i,(imax-2)) == 0
            KV(index) = -ntmp(imax,j+1)
        end
        index
    end
end
% KV(1) = -ntmp(1,2)-(c^2)*ntmp(2,1);
% KV(2) = -(c^2)*ntmp(3,1);
% KV(3) = -(c^2)*ntmp(4,1);
% KV(4) = -ntmp(6,2)-(c^2)*ntmp(5,1);
% KV(5) = -ntmp(1,3);
% KV(8) = -ntmp(6,3);
% KV(9) = -ntmp(1,4);
% KV(12) = -ntmp(6,4);
% KV(13) = -ntmp(1,5)-(c^2)*ntmp(3,6);
% KV(14) = -(c^2)*ntmp(3,6);
% KV(15) = -(c^2)*ntmp(4,6);
% KV(16) = -ntmp(6,5)-(c^2)*ntmp(5,6);

UK = KC\KV;
for j = 2:jmax-1
    for i = 2:imax-1
        index = (imax-2)*(j-2)+(i-1);
        ntmp(i,j) = UK(index);
    end
end

t = toc;
T = tmp';

fprintf('\n@@ Direct method: Five-point formula @@\n')
fprintf('Calculation time =%12.0f sec \n',t)

contour(x,y,T,'Showtext','on')
grid on
xlabel('x');
ylabel('y');
title('using Direct method: Five-point formula');
