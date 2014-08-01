clear all
clc
% 1. Readings by sensor
t=[1:pi/10:5*pi];

% 1.1 generating sensor noise, V(t)
n=length(t);
randn('seed',0)
noise=randn(n,1);

z=5*sin(t);
z=z.'+noise;

% corrected state vectors
x = zeros(10,1);
% corrected error co-variance matrix
P = ones(10,1);
% predicted state vectors
x_p = zeros(10,1);
% predicted error co-variance matrix
P_p = zeros(10,1);
%P_p(1) = 2;

% variance of disturbance noise
Q = .01; 
% variance of sensor noise
R = .1;
for k=1:n-1
    
    % prediction
    
    x_p(k+1) = x(k);
    P_p(k+1) = P(k) + Q;
    
    % correction
    
    K = P_p(k+1)/(P_p(k+1) + R);
    x(k+1) = x_p(k+1) + K*(z(k+1) - x_p(k+1));
    P(k+1) = (1 - K)* P_p(k+1);
    
    % plotting
    
    title('Voltage measured vs time');
    plot(k,x(k),'-ro',k,z(k), '-b*');
    %axis([1 10 .1 .7]);
    hleg1 = legend('Kalman filtered state','sensor measured state');
    set(hleg1,'Location','SouthWest');
    grid on
    hold on;
       
end
    
    