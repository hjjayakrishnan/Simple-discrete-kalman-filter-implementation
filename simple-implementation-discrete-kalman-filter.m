clear all
clc
% voltage readings by sensor
z = [.39, .50, .48, .29, .25, .32, .34, .48, .41, .45, .49];
z = z.';
% corrected state vectors
x = zeros(10,1);
% corrected error co-variance matrix
P = ones(10,1);
% predicted state vectors
x_p = zeros(10,1);
% predicted error co-variance matrix
P_p = zeros(10,1);

% variance of disturbance noise
Q = .1; 
% variance of sensor noise
R = .1;
for k=1:10
    
    % prediction
    
    x_p(k+1) = x(k);
    P_p(k+1) = P(k);
    
    % correction
    
    K = P_p(k+1)/(P_p(k+1) + R);
    x(k+1) = x_p(k+1) + K*(z(k+1) - x_p(k+1));
    P(k+1) = (1 - K)* P_p(k+1);
    
    % plotting
    
    title('Voltage measured vs time');
    plot(k,x(k),'-ro',k,z(k), '-b*');
    axis([1 10 .1 .7]);
    hleg1 = legend('Kalman filtered state','sensor measured state');
    set(hleg1,'Location','SouthWest');
    grid on
    hold on;
       
end
    
    