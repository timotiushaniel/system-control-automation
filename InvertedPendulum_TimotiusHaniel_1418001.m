clear all;

%% Iniasi Persamaan OLTF Pada Persamaan P_cart dan P_pend
M = 0.5;
m = 0.2;
b = 0.1;
I = 0.006;
g = 9.8;
l = 0.3;
q = (M+m)*(I+m*l^2)-(m*l)^2;

syms s
P_cart = (((I+m*l^2)/q)*s^2 - (m*g*l/q))/(s^4 + (b*(I + m*l^2))*s^3/q - ((M + m)*m*g*l)*s^2/q - b*m*g*l*s/q);

P_pend = (m*l*s/q)/(s^3 + (b*(I + m*l^2))*s^2/q - ((M + m)*m*g*l)*s/q - b*m*g*l/q);


%% TURUNAN DARI P_PEND (PERSAMAAN I)

% P_pend_diff = diff(P_pend)

%% TURUNAN DARI P_CART (PERSAMAAN II)

% P_cart_diff = diff(P_cart)

%% Mencari Nilai dari Zeros dan Poles P_pend dan P_cart

TFstr = char(P_cart);
TFstr2 = char(P_pend);
s = tf('s');
P_cart_tf = eval(TFstr);
P_pend_tf = eval(TFstr2);

sys_tf = [P_cart_tf ; P_pend_tf];

inputs = {'u'};
outputs = {'x'; 'phi'};

set(sys_tf,'InputName',inputs)
set(sys_tf,'OutputName',outputs)

t=0:0.01:1;
impulse(sys_tf,t);
title('Open-Loop Impulse Response')

[zeros poles] = zpkdata(P_pend_tf,'v')
[zeros poles] = zpkdata(P_cart_tf,'v')

%% Mencari Bentuk Plot dari Open Loop Step Response

% t = 0:0.05:10;
% u = ones(size(t));
% [y,t] = lsim(sys_tf,u,t);
% plot(t,y)
% title('Open-Loop Step Response')
% axis([0 3 0 50])
% legend('x','phi')

%% Mengubah OLTF ke Dalam Bentuk Transfer Function

P_pend_ss = ss(P_pend_tf)
P_cart_ss = ss(P_cart_tf)

%% Simulation 1: PID Control (Unstable Response Output) 

% Where: 
% >> Settling time is more than 5 seconds and (Should be less than 5s)
% >> Pendulum (The peak response) move more than 0.05 radians away from the vertical 
%    (Should be less than 0.05 radians)

Kp = 1;
Ki = 1;
Kd = 1;
C = pid(Kp,Ki,Kd);
T = feedback(P_pend_ss,C);

t=0:0.01:10;
impulse(T,t)
title({'Response of Pendulum Position to an Impulse Disturbance';'under PID Control: Kp = 1, Ki = 1, Kd = 1'});
%% Simulation 2: PID control (Still unstable Response Output)

% Where: 
% >> Settling time is less than 5 seconds and (OK)
% >> Pendulum (The peak response) still move more than 0.05 radians away from the vertical 
%    (Should be less than 0.05 radians)

Kp = 100;
Ki = 1;
Kd = 1;
C = pid(Kp,Ki,Kd);
T = feedback(P_pend_ss,C);
t=0:0.01:10;
impulse(T,t)
axis([0, 2.5, -0.2, 0.2]);
title({'Response of Pendulum Position to an Impulse Disturbance';'under PID Control: Kp = 100, Ki = 1, Kd = 1'});

%% Simulation 3: PID control (Stable Response Output)

% Where: 
% >> Settling time is less than 5 seconds and (OK)
% >> Pendulum (The peak response) is move less than 0.05 radians away from the vertical 
%    (OK)

Kp = 100;
Ki = 1;
Kd = 20;
C = pid(Kp,Ki,Kd);
T = feedback(P_pend_ss,C);
t=0:0.01:10;
impulse(T,t)
axis([0, 2.5, -0.2, 0.2]);
title({'Response of Pendulum Position to an Impulse Disturbance';'under PID Control: Kp = 100, Ki = 1, Kd = 20'});