function [A,B,C,D] = lrobot3(para,aux,Ts)
%DCMOTOR_M  ODE file representing the dynamics of a motor.
% The same DC-motor that was modeled by IDGREY; see IDDEMO7.

%   Copyright 2005-2014 The MathWorks, Inc.

% Output equations.
%y = [x(1)]; % Motor Torque
Kt = para(1); Kg = 9.68; Kb = Kt ; B = para(2); m = 2.96; R = 0.0610; dw = 0.28; L = dw/2; La = 23.62e-06; Ra = 3.3; I = 0.0285;  

A = [(-2*B*Kg^2)/((m*R^2)) 0  Kt*Kg/(La*R*m*R) Kt*Kg/(La*R*m*R) 
      0 -B*Kg*Kg*dw*dw/(2*I*R*R) Kg*Kt*dw/(2*I*R) -Kg*Kt*dw/(2*I*R)
      -Kb*Kg/(La*R) -Kb*Kg*dw/(2*La*R) -Ra/La 0
      -Kb*Kg/(La*R) Kb*Kg*dw/(2*La*R) 0 -Ra/La];
B = [0 0; 0 0; 1/La 0; 0 1/La]; 
C = [1/R L/R 0 0;  1/R -L/R 0 0]; 
D = [0 0; 0 0];
end
% State equations.
%dx = [(-5.8*10^5)*x(1)+Kt*((-4.09*10^5)*x(2)+(4.09*10^5)*u(1));  ... % Motor Torque Kt = Kt*4.09*10^5
%      (x(1)*Kdel/(9.68))+(-Bdel)*x(2) ];        % back EMF ];  % Kdel = Kb/Iw % Bdel = B/Iw