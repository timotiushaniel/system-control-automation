clear all;

%% Mencari Bode Plot dari Original Plant Sistem pada Motor
J = 3.2284E-6;
b = 3.5077E-6;
K = 0.0274;
R = 4;
L = 2.75E-6;
s = tf('s');

P_motor = K/(s*((J*s+b)*(L*s+R)+K^2))
bode(P_motor);
grid
title('Bode Plot of the Original Plant')

%% Mencari Bode Plot dari Lag Compensator
z = 100;
k = 500;

C=tf(k*[1 z],[1])
bode(C)
grid
title('Bode Plot of the Lag Compensator')

%% Mencari Step Response dari Lag Compensator
sys_cl = feedback(C*P_motor,1);
t = 0:0.01:1;
step(sys_cl), grid
title('Step Response with Lag Compensator')

info = stepinfo(sys_cl)

%% Convert Transfer Function ke dalam bentuk State Space Model

motor_ss = ss(sys_cl)

%% Menyimpan nilai tersebut ke dalam matrix A,B,C,D

A = [-1.455e+06  -1.472e+06       -8982
    1.049e+06           0           0
    0             1.638e+04         0];
B = [1024 ; 0; 0];
C = [0   1437  8.772];
D = [0];

%% Mencari Controllability menggunakan nilai matrix pada state space

Qc_matrix = ctrb(A,B)
QC_rank = rank(Qc_matrix)
% QC rank = 3
% Maka, sistem tersebut Controllable karena memiliki Full Rank 3
