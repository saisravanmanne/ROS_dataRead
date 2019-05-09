function [dx, y] = dcmotorfirst_order(t, x, u, a, c, d, varargin)
%DCMOTOR_M  ODE file representing the dynamics of a motor.
% The same DC-motor that was modeled by IDGREY; see IDDEMO7.

%   Copyright 2005-2014 The MathWorks, Inc.

% Output equations.
y = [x(1)]; % Motor Torque

% State equations.
dx = [ -a + (c/d)*u(1) ; x(2)       ... % back EMF 
     ];
  