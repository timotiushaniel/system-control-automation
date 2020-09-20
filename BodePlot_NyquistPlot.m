s = tf('s');

%% bode plot
G = 1 / (s + 1000);

% figure(1)
% options = bodeoptions;
% options.FreqUnits = 'Hz'; % or 'rad/second', 'rpm', etc.
% bode(G,options);
% hold on

figure(1)
% bode(G,options);
% hold on
bode(G);
hold on

%% nyquist plot
s = tf('s');
G = 1/(s^2 + 2*s + 1);
figure(2)
nyquist(G)
hold on