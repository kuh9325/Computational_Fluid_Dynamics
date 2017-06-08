function u = init(x,imax,jmax)

frontx = sum(x<=1);
midx = sum(x<=2);
rearx = sum(x<=3);

%% plotting waveform %%
u=zeros(imax,jmax);
for i = 1:imax
    if i <= frontx
        u(i,1) = 10*x(i);
    elseif i < midx && i > frontx
        u(i,1) = 10;
    elseif i <= rearx && i >= midx
        u(i,1) = -10*x(i)+30;
    else
        u(i,1) = 0;  
    end
end

end