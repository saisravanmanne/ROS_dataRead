clc;
close all;
clear all;
%% constant decleration 
ra1 = 7.7; % right motor
ra2 = 5.3; % left motor
Kg = 9.68;  % gear ratio
%% load the proper csv file in here and name it as killerKb;
% Kb this is for back emf calculation 
l = 2000; % size of the array
i_v = 12.10; % initial battery voltage
killerKb = csv2table('killme.csv',1,2000);
ea1 = i_v - (table2array(killerKb(1:l,12)))*4.8*10^(-3);  % right motor voltage
ia1 = table2array(killerKb(1:l,12))*34*10^(-3);  % right motor current
ws1 = table2array(killerKb(1:l,4));  % right motor angular velocity
volt = table2array(killerKb(1:l,14)); % input PWM value
Kb1 = (ea1 - ra1*ia1)./(Kg*ws1);   % right motor back emf calculation
%% plot without filtering
figure;
plot(ea1,Kb1,'r');
xlabel({'Input Voltge ea','in volts (V)'})
ylabel({'Back emf Kb','in volts/(radians/sec)'})
title('Right Motor')
%% filtering the noise in the ea1 values measured
% this is due to the 20KHz freq limitation 
average = mean(ea1);
std_dev = std(ea1);
for i = 1:length(ea1)
    if (ea1 < (average - std_dev))
        ea1(i) = [];
        ia1(i) = [];
        ws1(i) = [];
        Kb1(i) = [];
    end
    if (ea1 > (average + std_dev))
        ea1(i) = [];
        ia1(i) = [];
        ws1(i) = [];
        Kb1(i) = [];
     end
end
figure;
plot(ea1,Kb1,'r');
xlabel({'Input Voltge ea','in volts (V)'});
ylabel({'Back emf Kb','in volts/(radians/sec)'});
title('Right Motor (filtered)');








%% load the proper csv file in here and name it as killerKb;
% Kb this is for back emf calculation 
l = 2000; % size of the array
i_v = 12.10; % initial battery voltage
killerKb = csv2table('killme.csv',1,2000);
ea2 = i_v - (table2array(killerKb(1:l,10)))*4.8*10^(-3);  % right motor voltage
ia2 = table2array(killerKb(1:l,10))*34*10^(-3);  % right motor current
ws2 = table2array(killerKb(1:l,2));  % right motor angular velocity
volt = table2array(killerKb(1:l,14)); % input PWM value
Kb2 = (ea2 - ra2*ia1)./(Kg*ws2);   % right motor back emf calculation
%% plot without filtering
figure;
plot(ea2,Kb2,'r');
xlabel({'Input Voltge ea','in volts (V)'})
ylabel({'Back emf Kb','in volts/(radians/sec)'})
title('Light Motor')
%% filtering the noise in the ea1 values measured
% this is due to the 20KHz freq limitation 
average = mean(ea2);
std_dev = std(ea2);
for i = 1:length(ea2)
    if (ea2 < (average - std_dev))
        ea2(i) = [];
        ia2(i) = [];
        ws2(i) = [];
        Kb2(i) = [];
    end
    if (ea2 > (average + std_dev))
        ea2(i) = [];
        ia2(i) = [];
        ws2(i) = [];
        Kb2(i) = [];
     end
end
figure;
plot(ea2,Kb2,'r');
xlabel({'Input Voltge ea','in volts (V)'})
ylabel({'Back emf Kb','in volts/(radians/sec)'})
title('Left Motor (filtered)')


