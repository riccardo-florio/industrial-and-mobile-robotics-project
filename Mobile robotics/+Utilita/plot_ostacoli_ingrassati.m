function plot_ostacoli_ingrassati(ostacoli,x0,y0,G,r)
%PLOT_OSTACOLI_INGRASSATI
%   Esegue il plot della stanza con gli ostacoli reali ingrassati della
%   linghezza del raggio + 10% * raggio.

    figure(); axis('equal'); axis([-r 100+r -r 100+r]); hold on
    rectangle('Position', [ostacoli(1,1)-r ostacoli(1,2)-r ...
        ostacoli(4,1)-ostacoli(1,1)+2*r ...
        ostacoli(4,2)-ostacoli(1,2)+2*r], 'FaceColor', '#f3f3f3');
    rectangle('Position', [ostacoli(1,1) ostacoli(1,2) ...
        ostacoli(4,1)-ostacoli(1,1) ostacoli(4,2)-ostacoli(1,2)], ...
            'FaceColor', '#FFFFFF');
    for i=5:4:length(ostacoli)
        rectangle('Position', [ostacoli(i,1) ostacoli(i,2) ...
            ostacoli(i+3,1)-ostacoli(i,1) ostacoli(i+3,2)-ostacoli(i,2)]);
        rectangle('Position', [ostacoli(i,1)+r ostacoli(i,2)+r ...
            ostacoli(i+3,1)-ostacoli(i,1)-2*r ...
            ostacoli(i+3,2)-ostacoli(i,2)-2*r], 'FaceColor', '#f3f3f3');
    end
    plot(x0,y0,'*');plot(G(1),G(2),'*');

end

