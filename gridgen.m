clear all, clc

fnx = 50;  %size of xi-axis grid sys
fny = 100; %size of eta-axis grid sys
radi1 = 1.0; %radius of target
strch = 1.03;
arad = 3.0;
brad = 7.0;

theta = (pi/2)/(fnx-1);
imax = fnx;
jmax = fny;
x = zeros(imax,jmax);
y = zeros(imax,jmax);
z = zeros(imax,jmax); % for plane graph

% target surface / outer boundary grid %
for i = 1:imax
    x(i,1) = radi1*cos(pi-theta*(i-1)); % target surface
    y(i,1) = radi1*sin(pi-theta*(i-1));
    a = cos(pi-theta*(i-1)) / arad;
    b = sin(pi-theta*(i-1)) / brad;
    radi2 = 1/sqrt(a^2+b^2);
    x(i,jmax) = radi2*cos(pi-theta*(i-1)); % outer boundary
    y(i,jmax) = radi2*sin(pi-theta*(i-1));
end

% grid fill-in %
for j = 2:(jmax-1) % subtract target surface & outer boundary
    for i = 1:(imax-1) % subtract gridpoint on y-axis
        xleng = x(i,jmax) - x(i,1);
        yleng = y(i,jmax) - y(i,1);
        num = 1 - strch^(j-1);
        den = 1 - strch^(jmax-1);
        x(i,j) = x(i,1) + xleng*(num/den);
        y(i,j) = y(i,1) + yleng*(num/den);
    end
end

% align gridpoint on y-axis %
for j = 1:jmax
    yleng = y(imax,jmax) - y(imax,1);
    num = 1 - strch^(j-1);
    den = 1 - strch^(jmax-1);
    x(imax,j) = x(imax,1);
    y(imax,j) = y(imax,1) + yleng*(num/den);
end

mesh(x,y,z)