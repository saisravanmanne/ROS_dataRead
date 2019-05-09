clc
close all
clear all 
data_length = [2967 3014 1574 1501 5386 29854];
n = 6;
l1 = 1; 
l2 = data_length(n);
killerKb = csv2table('Rmotor.csv',l1,l2);
td = 1/105;
Wl = -table2array(killerKb(:,2));
Wr = table2array(killerKb(:,4));
%% plot the step response

plot((l1:l2)*td,Wl,'r');
xlabel({'Time','in seconds (s)'})
ylabel({'Angular Velocity (in rad/s)'})
title('Robot3 charateristics')
grid
hold on;
plot((l1:l2)*td,Wr)
legend('Angular Velocity Left Wheel','Angular Velocity Right Wheel');
hold off;
%% Family of W curves (Right_motor, Rmotor.csv)
x1 = Wl(5.638*105:10.638*105);
x2 = Wl(60.62*105:65.62*105);
x3 = Wl(107.4*105:112.4*105);
x4 = Wl(150.4*105:155.4*105);
x5 = Wl(226.4*105:231.4*105);
grid 
hold on
plot(0:1/105:5,x1); plot(0:1/105:5,x2); plot(0:1/105:5,x3); plot(0:1/105:5,x4); plot(0:1/105:5,x5);
title('Ang Velocity Response of Right Motor','FontSize', 14)
ylabel('\omega (rad/s)','FontSize', 14)
xlabel('Time (seconds)','FontSize', 14)
legend('at 11.65 V','at 10.77 V','at 10.19 V','at 9.61 V','at 8.73 V')
Ts = stepinfo(x1,0:1/105:5); Ts1 = Ts.SettlingTime;
Ts = stepinfo(x2,0:1/105:5); Ts2 = Ts.SettlingTime;
Ts = stepinfo(x3,0:1/105:5); Ts3 = Ts.SettlingTime;
Ts = stepinfo(x4,0:1/105:5); Ts4 = Ts.SettlingTime;
Ts = stepinfo(x5,0:1/105:5); Ts5 = Ts.SettlingTime;
Ts_avg = (Ts1 +Ts2 +Ts5)/3; Dom = 5/Ts_avg;

Dcgain = ((59.58/11.65)+(51.46/10.77)+(47.39/10.19)+(43.33/9.61)+(33.85/8.73))/5

ea = [11.75 10.84 10.23 9.66 8.8];
ia = [19.5 18.1 17.1 18.1 16];
Ra = 2.9; Kg = 9.68;
W = [45.5 37.8 37.6 26.31 19.28];
for i =1:5
Kb(i) = (ea(i)-Ra*ia(i)*10^-3)/(Kg*W(i)); 
end
Kt = mean(Kb);

Dcgain = 4.5858; Dom = -3.0471;
B = (Kt/(Ra))*((1/(Kg*Dcgain))-Kt); Iw = (Ra*B+Kt*Kt)/(Ra*Dom);


%% Family of W curves (left_motor, Lmotor.csv)
x1 = Wr(5.296*105:10.296*105);
x2 = Wr(38.78*105:43.78*105);
x3 = Wr(102.4*105:107.4*105);
x4 = Wr(127.6*105:132.6*105);
x5 = Wr(149.6*105:154.6*105);
grid 
hold on
plot(0:1/105:5,x1); plot(0:1/105:5,x2); plot(0:1/105:5,x3); plot(0:1/105:5,x4); plot(0:1/105:5,x5);
title('Ang Velocity Response of Left Motor','FontSize', 14)
ylabel('\omega (rad/s)','FontSize', 14)
xlabel('Time (seconds)','FontSize', 14)
legend('at 11.72 V','at 10.841 V','at 10.24 V','at 9.66 V','at 8.78 V')

Ts = stepinfo(x1,0:1/105:5); Ts1 = Ts.SettlingTime;
Ts = stepinfo(x2,0:1/105:5); Ts2 = Ts.SettlingTime;
Ts = stepinfo(x3,0:1/105:5); Ts3 = Ts.SettlingTime;
Ts = stepinfo(x4,0:1/105:5); Ts4 = Ts.SettlingTime;
Ts = stepinfo(x5,0:1/105:5); Ts5 = Ts.SettlingTime;
Ts_avg = (Ts1 +Ts3 + Ts4 +Ts5)/4; Dom = 5/Ts_avg;

ea = [11.8 10.90 10.29 9.71 8.83];
ia = [15.5 15.8 14.8 15.2 14.8];
Ra = 3.3; Kg = 9.68;
W = [58.5 49.7 43.51 38.2 29.29];
for i =1:5
Kb(i) = (ea(i)-Ra*ia(i)*10^-3)/(Kg*W(i)); 
end
Kt = mean(Kb);

Dcgain = ((58.23/11.72)+(47.39/10.24)+(41.98/9.66)+(35.21/8.78))/4

Dcgain = 4.4881; Dom = -2.1663;
B = (Kt/(Ra))*((1/(Kg*Dcgain))-Kt); Iw = (Ra*B+Kt*Kt)/(Ra*Dom);


%% 

%% post filteration
FWr = Wr((9.552/td):(17.27/td))
Input = 150*ones(1,length(((9.552/td):(17.27/td))))
Ft = ((((9.552/td):(17.27/td))*td) - 9.552)
plot(Ft,FWr)
hold on
step(tf([6.589],[1 0.354]))
step(4.46*tf([3.68],[1 0.5876]))
% stepinfo(tf([3.68],[1 0.5876])) %% after curve fitting
% bode(tf([3.68],[1 0.5876])) 
% allmargin(tf([3.68],[1 0.5876])) 
% % at 12.03 Volts
% stepinfo(12.03*tf([3.68],[1 0.5876]))
% step(12.03*tf([3.68],[1 0.5876]))
% % at 9.09 Volts
% stepinfo(9.09*tf([3.68],[1 0.5876]))
% step(9.09*tf([3.68],[1 0.5876]))