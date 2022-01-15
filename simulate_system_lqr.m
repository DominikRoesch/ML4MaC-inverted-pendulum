function [x_vec_lqr]=simulate_system_lqr(sys,x0,sim_steps,K)

A=sys.A;
B=sys.B;
nx=size(sys.A,1);

x_vec_lqr=[x0];


for ii=1:sim_steps
    u = -K*x_vec_lqr(:,ii);
    x = A*x_vec_lqr(:,ii) + B*u;
    x_vec_lqr = [x_vec_lqr x];
end

