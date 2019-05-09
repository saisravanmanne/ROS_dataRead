function [A,B,C,D] = ldcmotor_right(para, Ts)
%DCMOTOR_M  ODE file representing the dynamics of a motor.
% The same DC-motor that was modeled by IDGREY; see IDDEMO7.

%   Copyright 2005-2014 The MathWorks, Inc.

% Output equations.
%y = [x(1)]; % Motor Torque
Kt = para(1);
Kdel = para(2);
Bdel = para(3);

A = [(-5.8*10^5) Kt*(-4.09*10^5);  Kdel/(9.68) (-Bdel)];
B = [Kt*(4.09*10^5); 0];
C = [1 0];
D = [0];
if Ts>0 % Sample the model with sample time Ts
   s = expm([[A B]*Ts; zeros(1,3)]);
   A = s(1:2,1:2);
   B = s(1:2,3);
end
% State equations.
%dx = [(-5.8*10^5)*x(1)+Kt*((-4.09*10^5)*x(2)+(4.09*10^5)*u(1));  ... % Motor Torque Kt = Kt*4.09*10^5
%      (x(1)*Kdel/(9.68))+(-Bdel)*x(2) ];        % back EMF ];  % Kdel = Kb/Iw % Bdel = B/Iw
  