close all
clear all
clc

%% Load NN controller

load('neural_network.mat') % this gives the NN with n_1=n_2=5


%% Build the linearized system
% parameter definition
m = 0.15;           %[kg]
l = 0.5;            %[m]
mu = 0.5;           %[Nms/rad]
g = 9.81;           %[m/s²]
t_sim = 8;          %[s] Simulation time
t_disc = 0.02;      % discretization time
simsteps = t_sim/t_disc;    % Simulation steps

% linear System definition
A = [0      1
     g/l    -mu/(m*l^2)];
B = [0 1/(m*l^2)]';
C = eye(2);
n_x = size(A,2); % number of states

% system in continous and discrete time
inv_pen = ss(A,B,C,0);
inv_pen_d = c2d(inv_pen, t_disc);


%% Simulation
% Define initial condition
%x0 = [-0.733; 0];
x0 = [-0.08; 0];

% simulate linearized system with neural network controller
[star,x_vec]=simulate_system(W,b,inv_pen_d,x0,simsteps);

% simulate linearized system with an LQR
Q = eye(2);
R = 1;
[K,S,e] = lqr(inv_pen_d,Q,R);
x_vec_lqr = simulate_system_lqr(inv_pen_d,x0,simsteps,K);

% simulate nonlinear system with neural network controller
[star_nl,x_vec_nl]=simulate_nonlinear_system(W,b,m,g,l,mu,t_disc,x0,simsteps);

% simulate nonlinear system with LQR
x_vec_lqr_nl = simulate_nonlinear_system_lqr(m,g,l,mu,t_disc,x0,simsteps,K);

% Create the time axis
t = linspace(0,simsteps,simsteps+1);
t = t*t_disc;

% Plot the results
figure
plot(t,x_vec(1,:),t,x_vec_nl(1,:),t,x_vec_lqr(1,:),t,x_vec_lqr_nl(1,:));
xlabel('time in seconds') 
ylabel('angle theta in rad')
legend('NN linear','NN nonlinear','LQR linear','LQR nonlinear','Location','east');
%title('Stabilization of the inverse pendulum with different approaches');


