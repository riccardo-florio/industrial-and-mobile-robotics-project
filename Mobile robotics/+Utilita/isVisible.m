function visible = isVisible(P1, P2, ostacoli)
%IS_VISIBLE
%   Funzione che determina se il punto P1 è visibile dal punto P2
    
    visible = true;
    x=linspace(P1(1),P2(1),100);
    y=linspace(P1(2),P2(2),100);

    for i=1:length(x)
        for o=5:4:size(ostacoli(:,1))
            if ostacoli(o,1)<x(i) && x(i)<ostacoli(o+1,1) && ...
                    ostacoli(o,2)<y(i) && y(i)<ostacoli(o+2,2)

                visible = false;
                return
            end
        end
    end
end