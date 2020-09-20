%Lead or Phase-lead compensator using root locus Design
clear all;
s = tf('s');
Kc = 24.2083;
z = 8.0501;
p = 3.385;
P=1;
C_lead = Kc*(s-z)/(s-p);
sys_ol = C_lead*P;
bode(sys_ol);


%Lag or Phase-lag compensator using frequency response
% clear all;
% s=tf('s');
% a = 0.83;
% T = 3.25;
% C_lag = (1+a*T*s)/(1+T*s);
% P = 1/T;
% sys_ol = C_lag*P;
% bode(sys_ol);

J = 3.2284E-6;
b = 3.5077E-6;
K = 0.0274;
R = 4;
L = 2.75E-6;
s = tf('s');
P_motor = K/(s*((J*s+b)*(L*s+R)+K^2))

A = [0 1 0
    0 -b/J K/J
    0 -K/L -R/L];
B = [0 ; 0 ; 1/L];
C = [1 0 0];
D = [0];

motor_ss = ss(A,B,C,D)