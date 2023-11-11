function plot_trends_2(t2,x1,y1,G,theta1,thehaG)
% PLOT_TRENDS_2
%   Plots the trends of the actual position and orientation variables
%   along with the reference ones obtained during the posture regulation
%   phase.

    figure();
    subplot(311);hold on;
    title('Andamento di x');
    plot(t2,ones(size(t2)).*G(1),'LineWidth',1.5);
    plot(t2,x1,'LineWidth',1.5);
    legend('x-star','x','Location','best');
    
    subplot(312);hold on;
    title('Andamento di y');
    plot(t2,ones(size(t2))*G(2),'LineWidth',1.5);
    plot(t2,y1,'LineWidth',2);
    legend('y-star','y','Location','best');
    
    subplot(313);hold on;
    title('Andamento di θ');
    plot(t2,ones(size(t2))*thehaG,'LineWidth',1.5);
    plot(t2,(theta1),'LineWidth',1.5);
    legend('θ-star','θ','Location','best');

end

