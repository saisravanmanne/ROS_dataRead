clc;
close all;
clear all;
%% constant decleration 
ra1 = 4.641; % right motor
ra2 = 3.934; % left motor
Kg = 9.68;  % gear ratio
%% load the proper csv file in here and name it as killerKb;
% Kb this is for back emf calculation
l1 = 1;
l2 = 200; % size of the array
i_v = 11.85; % initial battery voltage
killerKb = csv2table('data_test_1.csv',l1,l2);
ea1 = i_v - (table2array(killerKb(:,12)))*4.8*10^(-3);  % right motor voltage
ia1 = table2array(killerKb(:,12))*34*10^(-3);  % right motor current
ws1 = table2array(killerKb(:,4));  % right motor angular velocity
volt = table2array(killerKb(:,14)); % input PWM value
%% 0 Ws1 filtering
rlength = length(ws1);
i = 1;
while (rlength - i) > 0
    if (~((ws1(i)) == 0))
     i = i+1;
    end
    if (ws1(i) == 0)
        ea1(i) = [];
        ia1(i) = [];
        ws1(i) = [];
    end
     rlength=length(ws1);
end
Kb1 = (ea1 - ra1*ia1)./(Kg*ws1);   % right motor back emf calculation
%% plot without filtering
figure;
stem(ea1,Kb1,'r');
xlabel({'Input Voltge ea','in volts (V)'})
ylabel({'Back emf Kb','in volts/(radians/sec)'})
title('Right Motor')
%% filtering the noise in the ea1 values measured
% this is due to the 20KHz freq limitation 
average = mean(Kb1);
std_dev = std(Kb1);
rlength = length(Kb1);
i = 1;
while (rlength - i) > 0
    if (~((Kb1(i) < (average - std_dev))||(Kb1(i) > (average + std_dev))))
     i = i+1;
    end
    if (Kb1(i) < (average - std_dev))
        ea1(i) = [];
        ia1(i) = [];
        ws1(i) = [];
        Kb1(i) = [];
    end
    if (Kb1(i) > (average + std_dev))
        ea1(i) = [];
        ia1(i) = [];
        ws1(i) = [];
        Kb1(i) = [];
    end
     rlength=length(Kb1);
end
figure;
stem(ea1,Kb1,'r');
xlabel({'Input Voltge ea','in volts (V)'});
ylabel({'Back emf Kb','in volts/(radians/sec)'});
title('Right Motor (filtered)');
filt_average_1 = mean(Kb1);







%% load the proper csv file in here and name it as killerKb;
% Kb this is for back emf calculation 
killerKb = csv2table('data_test_1.csv',l1,l2);
ea2 = i_v - (table2array(killerKb(:,10)))*4.8*10^(-3);  % right motor voltage
ia2 = table2array(killerKb(:,10))*34*10^(-3);  % right motor current
ws2 = table2array(killerKb(:,2));  % right motor angular velocity
volt = table2array(killerKb(:,14)); % input PWM value
%% 0 Ws2 filtering
rlength = length(ws2);
i = 1;
while (rlength - i) > 0
    if (~((ws2(i)) == 0))
     i = i+1;
    end
    if (ws2(i) == 0)
        ea2(i) = [];
        ia2(i) = [];
        ws2(i) = [];
    end
     rlength=length(ws2);
end
Kb2 = (ea2 - ra2*ia2)./(Kg*ws2);   % right motor back emf calculation
%% plot without filtering
figure;
stem(ea2,Kb2,'r');
xlabel({'Input Voltge ea','in volts (V)'})
ylabel({'Back emf Kb','in volts/(radians/sec)'})
title('Left Motor')
%% filtering the noise in the ea1 values measured
% this is due to the 20KHz freq limitation 
average = mean(Kb2);
std_dev = std(Kb2);
rlength = length(Kb2);
i = 1;
while (rlength - i) > 0
    if (~((Kb2(i) < (average - std_dev))||(Kb2(i) > (average + std_dev))))
     i = i+1;
    end
    if (Kb2(i) < (average - std_dev))
        ea2(i) = [];
        ia2(i) = [];
        ws2(i) = [];
        Kb2(i) = [];
    end
    if (Kb2(i) > (average + std_dev))
        ea2(i) = [];
        ia2(i) = [];
        ws2(i) = [];
        Kb2(i) = [];
    end
     rlength=length(Kb2);
end
figure;
stem(ea2,Kb2,'r');
xlabel({'Input Voltge ea','in volts (V)'})
ylabel({'Back emf Kb','in volts/(radians/sec)'})
title('Left Motor (filtered)')
filt_average_2 = mean(Kb2);

%% record of back emf values at different voltages

voltage1 = [11.4126 11.4728 11.5334 11.5770 11.6209];
back_emf1 = [0.0197 0.0139 -0.0018 -0.0176 -0.0481];
voltage2 = [11.3541 11.4173 11.4892 11.5369 11.5951];
back_emf2 = [0.0140 0.0086 -0.0053 -0.0181 -0.0509 ];

% from 400 to 150 
% input_voltages ea1 = [11.87 11.39 11.09 10.70 10.10 9.09];
% input_voltages ea2 = [11.86 11.41 11.18 10.80 10.27 9.37];
% done and dusted
