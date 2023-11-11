function plot_trends_1(t,x,x_star,y,y_star,theta,theta_star,...
    scelta_tecnica,b)
%% PLOT_TRENDS_1
%   Plots the trends of the actual position and orientation variables
%   along with the reference ones obtained during the trajectory tracking
%   phase. Then, it prints the tracking errors of these variables.


    figure();
    subplot(321);hold on;
    title('Andamento di x');
    plot(t,x_star(t),'LineWidth',1.5);
    plot(t,x,'LineWidth',1.5);
    legend('x-star','x','Location','best');
    subplot(322);hold on; 
    plot(t,x_star(t)-x);
    title('Errore lungo x');

    subplot(323);hold on;
    title('Andamento di y');
    plot(t,y_star(t),'LineWidth',1.5);
    plot(t,y,'LineWidth',1.5);
    legend('y-star','y','Location',"best");
    subplot(324);hold on; 
    plot(t,y_star(t)-y);
    title('Errore lungo y');

    subplot(325);hold on;
    title('Andamento di θ');
    plot(t,(theta_star(t)),'LineWidth',1.5);
    plot(t,theta,'LineWidth',1.5);
    legend('θ-star','θ','Location',"best");
    subplot(326);hold on;
    title('Errore di θ');
    if scelta_tecnica==1 || scelta_tecnica==2
        plot(t,rad2deg(Utility.delta_angle(theta_star(t),theta)));
    else
        err=sqrt((x_star(t)-x).^2+(y_star(t)-y).^2);
        plot(t,err);
        plot(t,ones(size(t))*b,'--k');
    end

end

