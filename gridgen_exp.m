clear all, clc

syms app fx fy

fnx = 10;  %size of xi-axis grid sys
fny = 20; %size of eta-axis grid sys
radi1 = 1.0; %radius of target
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
        fx = xleng == app*exp(jmax);
        fy = yleng == app*exp(jmax);
        ax = solve(fx,app);
        ay = solve(fy,app);
        sx = ax*exp(j);
        sy = ay*exp(j);
        x(i,j) = x(i,1) + sx;
        y(i,j) = y(i,1) + sy;
    end
end

% align gridpoint on y-axis %
for j = 1:jmax
    yleng = y(imax,jmax) - y(imax,1);
    fy = yleng == app*exp(jmax);
    ay = solve(fy,app);
    sy = ay*exp(j);
    x(imax,j) = x(imax,1);
    y(imax,j) = y(imax,1) + sy;
end

% plotting on 2d plane %
mesh(x,y,z)