clear all, clc

aoa = -20:20; %angle of attack
% remove data after stall angle
info = {'NACA-1408','NACA-2414','NACA-4412','NACA-6409';...
    '12:31','6:36','9:35','11:34'};
value = ...
    ' Total lift coefficient   =   %f      Total drag coefficient   = %f Total moment coefficient =  %f';
cl = zeros(41,4);
cd = zeros(41,4);
cm = zeros(41,4);
ld = zeros(41,4); % lift/drag ratio
for k = 1:4 % four kind of NACA 4 digits (extract from info)
    for j = 1:41 % -20~20
        num = j-21;
        path = sprintf(['/Users/alexiankim/Downloads/coeff/',...
            char(info(1,k)),'/',num2str(num),'/force_com.dat']);
        fid = fopen(path,'r');
        [log,cnt] = fscanf(fid,value,[3 inf]);
        fclose(fid);
        cl(j,k)=log(1);
        cd(j,k)=log(2);
        cm(j,k)=log(3);
    end
end

for i = 1:41
    for j = 1:4
        ld(i,j) = cl(i,j)/-cd(i,j);
    end
end

for i = 1:4
    figure(i)
    refine = str2num(char(info(2,i)));
    plot(aoa(refine),cl(refine,i),'o-')
    title([char(info(1,i)),': lift coefficient versus AOA']);
    xlabel({'angle of attack (\circ)'});
    ylabel({'c_{L}'});
end
for i = 1:4
    figure(i+4)
    refine = str2num(char(info(2,i)));
    plot(aoa(refine),cd(refine,i),'o-')
    title([char(info(1,i)),': drag coefficient versus AOA']);
    xlabel({'angle of attack (\circ)'});
    ylabel({'c_{D}'});
end
for i = 1:4
    figure(i+8)
    refine = str2num(char(info(2,i)));
    plot(cd(refine,i),cl(refine,i),'o-')
    title([char(info(1,i)),': lift coeff versus drag coeff']);
    xlabel({'c_{D}'});
    ylabel({'c_{L}'});
end
for i = 1:4
    figure(i+12)
    refine = str2num(char(info(2,i)));
    plot(aoa(refine),ld(refine,i),'o-')
    title([char(info(1,i)),': lift/drag ratio versus AOA']);
    xlabel({'angle of attack (\circ)'});
end