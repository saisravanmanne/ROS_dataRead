clc
close all 
clear all 
%% About the Input-Output Data
%
% 1. Load the DC motor data.
load(fullfile(matlabroot, 'toolbox', 'ident', 'iddemos', 'data', 'dcmotordata'));

%%
% 2. Represent the estimation data as an |iddata| object. 
z = iddata(y(:,2), u, 'Name', 'DC-motor');

%%
% 3. Specify input and output signal names, start time and time units. 
z.InputName = 'Voltage';
z.InputUnit =  'V';
z.OutputName = {'Angular velocity'};
z.OutputUnit = {'rad/s'};
z.Tstart = 0;
z.TimeUnit = 's';
%%
% 4. Plot the data.
%
% The data is shown in two plot windows.
figure('Name', [z.Name ': Voltage input -> Angular velocity output']);
plot(z(:, 1));   % Plot second input-output pair (Voltage -> Angular velocity).


par = [0.00095; 5688; 1.97];
aux = {};
Ts = 0;
m = idgrey('ldcmotor_right',par,'c',aux,Ts);
m.Structure.Parameters.Minimum = [0;5000;0];
m.Structure.Parameters.Maximum = [1;Inf;10];

opt = greyestOptions('SearchMethod','gna','Display', 'on','Focus','prediction','InitialState','estimate');
opt.Regularization.Lambda = 10^-10;
m_est = greyest(z,m,opt);
compare(z,m_est);