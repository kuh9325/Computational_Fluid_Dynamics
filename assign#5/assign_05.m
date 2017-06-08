clear all, clc

cl = zeros(20,4);
cd = zeros(20,4);
for k = 1:4
    for j = 1:20 % -4~15
        num = j-5;
        address=sprintf('/Users/alexiankim/Downloads/coeff/%d/%d/coefhist000.rlt',k,num);
        fid=fopen(address,'r');
        for i=1:2
            buffer=fgetl(fid);
        end
        [a, b]=fscanf(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f',[16 450]);
%         [log, cnt]=fscanf(fid,' Total lift coefficient   =   %f      Total drag coefficient   = %f Total moment coefficient =  %f',[3 inf]);
        fclose(fid);
        cl(j,k)=sum(a(2,400:450))/51;
        cd(j,k)=sum(a(3,400:450))/51;
    end
end

aoa = -4:15; %angle of attack


ld = zeros(20,4);
for i = 1:20
    for j = 1:4
        ld(i,j) = cl(i,j)/-cd(i,j);
    end
end

plot(cd(:,1),cl(:,1),'o-')

figure(1)
plot(aoa,cl(:,1),'o-')
title('NACA-1408: lift coefficient versus AOA');
xlabel({'angle of attack (\circ)'});
ylabel({'c_{L}'});

figure(2)
plot(aoa,cd(:,1),'o-')
title('NACA-1408: drag coefficient versus AOA');
xlabel({'angle of attack (\circ)'});
ylabel({'c_{D}'});

figure(3)
plot(aoa,cl(:,2),'o-')
title('NACA-2414: lift coefficient versus AOA');
xlabel({'angle of attack (\circ)'});
ylabel({'c_{L}'});

figure(4)
plot(aoa,cd(:,2),'o-')
title('NACA-2414: drag coefficient versus AOA');
xlabel({'angle of attack (\circ)'});
ylabel({'c_{D}'});

figure(5)
plot(aoa,cl(:,3),'o-')
title('NACA-4412: lift coefficient versus AOA');
xlabel({'angle of attack (\circ)'});
ylabel({'c_{L}'});

figure(6)
plot(aoa,cd(:,3),'o-')
title('NACA-4412: drag coefficient versus AOA');
xlabel({'angle of attack (\circ)'});
ylabel({'c_{D}'});

figure(7)
plot(aoa,cl(:,4),'o-')
title('NACA-6409: lift coefficient versus AOA');
xlabel({'angle of attack (\circ)'});
ylabel({'c_{L}'});

figure(8)
plot(aoa,cd(:,4),'o-')
title('NACA-6409: drag coefficient versus AOA');
xlabel({'angle of attack (\circ)'});
ylabel({'c_{D}'});

figure(9)
plot(aoa,ld(:,1),'o-')
title('NACA-1408: lift/drag ratio versus AOA');
xlabel({'angle of attack (\circ)'});

figure(10)
plot(aoa,ld(:,2),'o-')
title('NACA-2414: lift/drag ratio versus AOA');
xlabel({'angle of attack (\circ)'});

figure(11)
plot(aoa,ld(:,3),'o-')
title('NACA-4412: lift/drag ratio versus AOA');
xlabel({'angle of attack (\circ)'});

figure(12)
plot(aoa,ld(:,4),'o-')
title('NACA-6409: lift/drag ratio versus AOA');
xlabel({'angle of attack (\circ)'});