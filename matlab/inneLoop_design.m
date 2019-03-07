%% Inner Loop Design and Plant Analysis 
clc 
close all 
clear all 
%% constant declerations
m = 3.02 % in Kg
Iz = 0.0421502 % in Kgm^2
r = 0.06 % in m
d_w = 0.33 % in m 




L = [0.28] ; % Length of robot 
W = [0.254] ; % width of robot base
d_w = [0.36] ; % width including wheels
Kb = [0.0019] ; % Back emf in Volts
Kt = [Kb] ;% Torque constant
Kg = [9.68] ; %9.68
Ra = [(4.641+3.934)/2] ;
La = [0.5*(1367.7+1389.9)*1e-6];
dcgain = 9.754 ; % DC gain
dominant_pole = 4.1667 ; % dominant pole 
Iw = (Kt/(Kg*Ra))/(dominant_pole*dcgain) ;
Im = Iw/2 ;
b = (dominant_pole*Iw*Ra - Kt*Kb)/Ra ;





c = 1;
%% Linearized Plant State Space Matrixes
% Plant from [er el] to [wr wl]
%
A = [-2*(b*Kg(c)*Kg(c))/(m*r*r)    0    (Kt*Kg(c))/(m*r)    (Kt*Kg(c))/(m*r) ;
      0    (-b*Kg*Kg*d_w*d_w)/(2*Iz*r*r)    (Kg*Kt*d_w)/(2*Iz*r)    (-Kg*Kt*d_w)/(2*Iz*r);
      -Kb*Kg(c)/(La*r)    -Kb*Kg(c)*d_w/(2*La*r)    -Ra/La    0 ;
      -Kb*Kg(c)/(La*r)    Kb*Kg(c)*d_w/(2*La*r)    0    -Ra/La ];
B = [0 0; 0 0; 1/La 0; 0 1/La];
C = [1/r  d_w/(2*r) 0 0 ;
     1/r -d_w/(2*r) 0 0];
D = [0 0; 0 0];

P_ss = ss(A,B,C,D)
s = tf([1 0],[1]);
P_tf = tf(P_ss);
P_tf = zpk(P_tf)
P_approx = [P_tf(1,1) 0; 0 P_tf(2,2)]
%Finding the transmission zeros involved for the low freq approximation
%model
P_tf = P_approx;
z = tzero(P_tf);
H1 = evalfr(P_tf,z(1));
svd(H1)
H1 = evalfr(P_tf,z(2));
svd(H1)
H1 = evalfr(P_tf,z(3));
svd(H1)
H1 = evalfr(P_tf,z(4));
svd(H1)
% for the low freq approximation model there are no transmission zeros 
%% PI Controller Design 


