%% using Direct method: Five-point formula

function DFP(tmp,beta,x,y,imax,jmax)

sM = (imax-2)*(jmax-2); % size of matrix

KC = zeros(sM); KV = zeros(sM,1);
a = 1; b = 1; c = beta; d = -2*(1+beta^2);
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
        KC(i+1,i) = 0; KC(i,i+1) = 0;
    end
end

for j = 1:jmax-2
    for i = 1:imax-2
        index = (imax-2)*(j-1)+(i);
        if j == 1 
            if mod(i,(imax-2)) == 1
                KV(index) = -ntmp(1,2)-(c^2)*ntmp(2,1);
            elseif mod((imax-2),i) == 0
                KV(index) = -ntmp(imax,2)-(c^2)*ntmp(imax-1,1);
            else
                KV(index) = -(c^2)*ntmp(i+1,1);
            end
        elseif j == jmax-2
            if mod(i,(imax-2)) == 1
                KV(index) = -ntmp(1,jmax-1)-(c^2)*ntmp(2,jmax);
            elseif mod(i,(imax-2)) == 0
                KV(index) = -ntmp(imax,jmax-1)-(c^2)*ntmp(imax-1,jmax);
            else
                KV(index) = -(c^2)*ntmp(i+1,jmax);
            end
        elseif mod(i,(imax-2)) == 1
            KV(index) = -ntmp(1,j+1);
        elseif mod(i,(imax-2)) == 0
            KV(index) = -ntmp(imax,j+1);
        end
    end
end

UK = KC\KV;
for j = 2:jmax-1
    for i = 2:imax-1
        index = (imax-2)*(j-2)+(i-1); ntmp(i,j) = UK(index);
    end
end

T = ntmp';

contour(x,y,T,'Showtext','on')
grid on
xlabel('x'); ylabel('y');
title('using Direct method: Five-point formula');

end