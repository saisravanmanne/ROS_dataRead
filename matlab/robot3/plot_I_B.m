clc;
close all;
clear all;
%% constant decleration
%% load the proper csv file in here and name it as killerKb;
% Kb this is for back emf calculation 
l = 2000; % size of the array
i_v = 12.10; % initial battery voltage
killerKb = csv2table('killme.csv',1,2000);
ea1 = i_v - (table2array(killerKb(1:l,12)))*4.8*10^(-3);  % right motor voltage
ia1 = table2array(killerKb(1:l,12))*34*10^(-3);  % right motor current
ws1 = table2array(killerKb(1:l,4));  % right motor angular velocity
volt = table2array(killerKb(1:l,2)); % input PWM value
time = table2array(killerKb(1:l,8)); % time of recording
time = time - time(1);
%% plot the step response
figure;
plot(ws1,time,'r');
xlabel({'Time','in milli-seconds (ms)'})
ylabel({'Angular Velocity','in (radians/sec)'})
title('Right Motor at voltage ')














%% load the proper csv file in here and name it as killerKb;
% Kb this is for back emf calculation 
l = 2000; % size of the array
i_v = 12.10; % initial battery voltage
killerKb = csv2table('killme.csv',1,2000);
ea2 = i_v - (table2array(killerKb(1:l,10)))*4.8*10^(-3);  % right motor voltage
ia2 = table2array(killerKb(1:l,10))*34*10^(-3);  % right motor current
ws2 = table2array(killerKb(1:l,2));  % right motor angular velocity
volt = table2array(killerKb(1:l,14)); % input PWM value
time = table2array(killerKb(1:l,8)); % time of recording
time = time - time(1);
%% plot the step response
figure;
plot(ws2,time,'r');
xlabel({'Time','in milli-seconds (ms)'})
ylabel({'Angular Velocity','in (radians/sec)'})
title('Left Motor at voltage ')