
%% create figure
hFig = figure;
%x = 0:0.01:1;
hold on
plot(t,x_vec(1,:),'k')
plot(t,x_vec_nl(1,:),'--b')
plot(t,x_vec_lqr(1,:),'r')
plot(t,x_vec_lqr_nl(1,:),'--g')
xlabel('time (s)','Interpreter','latex') 
ylabel('angle (rad)','Interpreter','latex')
legend('NN linear','NN nonlinear','LQR linear','LQR nonlinear','Interpreter','latex','Location','east')
%title('Lineares System','Interpreter','latex')
grid on
set(gca,'xtick',0:1:8)
set(gca,'ytick',-0.09:0.01:0.01)
set(gca,'ylim',[-0.09 0.01])
set(gca,'xlim',[0 8])

% add matlab2tikz to the Matlab Path (choose as width of the figure a
% parameter which you can later set in LaTeX (here: "\figurewidth"))
matlab2tikz('lin_nl_008.tikz','width','\figurewidth', 'encoding', 'utf8' )