clc;
close all;
clear all;
%% constant decleration
ra1 = 4.641; % right motor
ra2 = 3.934; % left motor
Kg = 9.68;  % gear ratio
Kb = 0;
Kt = Kb;
%% load the proper csv file in here and name it as killerKb;
% Kb this is for back emf calculation 
l1 = 601;
l2 = 900; % size of the array
i_v = 11.85; % initial battery voltage
killerKb = csv2table('data_test_4.csv',l1,l2);
ea1 = i_v - (table2array(killerKb(:,12)))*4.8*10^(-3);  % right motor voltage
ia1 = table2array(killerKb(:,12))*34*10^(-3);  % right motor current
ws1 = table2array(killerKb(:,4));  % right motor angular velocity
volt = table2array(killerKb(:,14)); % input PWM value
time = table2array(killerKb(:,8)); % time stamp
time = time - time(1);
%% plot the step response
figure;
plot(time,-1*ws1,'r');
xlabel({'Time','in milli-seconds (ms)'})
ylabel({'Angular Velocity','in (radians/sec)'})
title('Right Motor at voltage 11.87V')

% from 400 to 150 
% input_voltages ea1 = [11.87 11.39 11.09 10.70 10.10 9.09];
% input_voltages ea2 = [11.86 11.41 11.18 10.80 10.27 9.37];











%% load the proper csv file in here and name it as killerKb;
% Kb this is for back emf calculation 
killerKb = csv2table('data_test_4.csv',l1,l2);
ea2 = i_v - (table2array(killerKb(:,10)))*4.8*10^(-3);  % right motor voltage
ia2 = table2array(killerKb(:,10))*34*10^(-3);  % right motor current
ws2 = table2array(killerKb(:,2));  % right motor angular velocity
volt = table2array(killerKb(:,14)); % input PWM value
%% plot the step response
figure;
plot(time,-1*ws2,'r');
xlabel({'Time','in milli-seconds (ms)'})
ylabel({'Angular Velocity','in (radians/sec)'})
title('Left Motor at voltage ')
%% Final Calculations 

Kb = 0.0019;  % back emf in V
Kt = Kb;  % torque constant
Kg = 9.68; % gear ratio
Ra1 = 4.641; % right motor armature resistance in ohm
Ra2 = 3.934; % left motor
La1 = 1367.7*10^(-6); % right motor armature inductanve in H
La2 = 1389.9*10^(-6); 

% Right motor characteristics
Ra = Ra1;
La = La1;
DC = 3.52;  % DC gain
ple = 2.7;  % Dominant pole
B = (((Kt/Kg)/DC) - (Kt*Kb))/Ra;
I = B/ple + Kt*Kb/(Ra*ple);
s = tf([1 0],[1]);
model = ((Kt/Kg)/(((I*s + B)*Ra) + Kt*Kb))*(Ra/(La*s + Ra));
figure;
step(model*11.09)


% from 400 to 150 
% input_voltages ea1 = [11.87 11.39 11.09 10.70 10.10 9.09];
% input_voltages ea2 = [11.86 11.41 11.18 10.80 10.27 9.37];



