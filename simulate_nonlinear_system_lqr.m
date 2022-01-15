function [x_vec_lqr]=simulate_nonlinear_system_lqr(m,g,l,mu,t_disc,x0,sim_steps,K)

x_vec_lqr=[x0];


for ii=1:sim_steps
    x = x_vec_lqr(:,ii);
    u = -K*x;
    x_merker = x(1);
    x(1) = x(1) + x(2)*t_disc;
    x(2) = x(2) + (m*g*l*sin(x_merker)-mu*x(2)+u)/m/l^2*t_disc;
    x_vec_lqr = [x_vec_lqr x];
end

