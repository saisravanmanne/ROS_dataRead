clc
close all 
clear all 
 m = 2.96 ;
 mw = 0.279 ;
 mc = m -mw ;
% Iw = 
% I =
% Ic = 
%% Iw estimation

rw =  0.0610 ; m_wheel = 0.181;
rm = 0.0248  ; m_motor = 0.096;
maxval =  m_motor*rm*rm + m_wheel*rw*rw;
minval =  maxval/8;
%% Ic calculation
% 
% plate
Ic = 0;
m_plate = 0.411;
L = 0.28/2;
Ic = Ic + (8/6)*m_plate*(L*L);
% 3d print
m3d = 0.055;
l3d = 0.079;
Ic = Ic + 2*m3d*l3d*l3d;
% Nvidia
m_nvidia = 0.4;
l_nvidia = 0.03;
Ic = Ic + m_nvidia*l_nvidia^2;
% battery
m_bat = 0.492;
l = 0.108;
w = 0.101;
Ic = Ic + (1/12)*m_bat*(l*l + w*w);
% camera 
m_cam = 0.077;
l_cam = 0.101;
Ic = Ic + m_cam*l_cam*l_cam;
% LiPo
m_lipo = 0.185;
l_lipo = 0.101;
l = 0.10;
w = 0.034;
Ic = Ic + m_lipo*(l_lipo*l_lipo) + m_lipo*(l*l + w*w);
% arduino + motor shield 
m_ard_shield = 0.062;
L_ard_shield = 0.033;
Ic = Ic + m_ard_shield*(L_ard_shield)^2;
%% I approximation

I_approx = (8/12)*m*L*L; 
%% I original
Iw = maxval;
Iw = 8.5978e-05;
I = Ic + 2*mw*L*L + Iw;

