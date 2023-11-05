function [path] = Artificial_Potential_Fields(start,goal,stanza,ostacoli)
%ARTIFICIAL_POTENTIAL_FIELDS
%   Calculate the path using the Artificial Potential Fields method

    X0 = start;
    G = goal;
    O = stanza;

    %% Calculation of the total potential
    %  Definition of the functions Ja (attractive potential) 
    %  and Jr (repulsive potential)
    Ja=@(x,y,Gx,Gy)((1/2)*((x-Gx).^2+(y-Gy).^2));
    Jr=@(x,y,Ox,Oy)(1./((x-Ox).^2+(y-Oy).^2));
    
    % Definition of the gradients of the above functions
    nablaJaX=@(x,y,Gx,Gy)(x-Gx);
    nablaJaY=@(x,y,Gx,Gy)(y-Gy);
    nablaJrX=@(x,y,Ox,Oy)(2*(Ox-x)./(((x-Ox).^2+(y-Oy).^2)));
    nablaJrY=@(x,y,Ox,Oy)(2*(Oy-y)./(((x-Ox).^2+(y-Oy).^2)));
    
    % Validity region
    dmin=3;
    rho=@(x,y,Ox,Oy)((x-Ox).^2+(y-Oy).^2<=dmin^2);
    
    % Weights for the attractive and repulsive potentials, respectively.
    wa=1;
    wo=100;
    
    % Definition of the workspace
    xm=min(X0(1),G(1));xm=min(xm,min(O(:,1)));
    xM=max(X0(1),G(1));xM=max(xM,max(O(:,1)));
    ym=min(X0(2),G(2));ym=min(ym,min(O(:,2)));
    yM=max(X0(2),G(2));yM=max(yM,max(O(:,2)));
    
    deltaXY=1;
    xx=xm:deltaXY:xM;
    yy=ym:deltaXY:yM;
    [XX,YY]=meshgrid(xx,yy);

    % ATTRACTIVE POTENTIAL
    Za=Ja(XX,YY,G(1),G(2));
    nablaJaXX=nablaJaX(XX,YY,G(1),G(2));
    nablaJaYY=nablaJaY(XX,YY,G(1),G(2));
    % Plot
    figure(); grid; surf(XX,YY,Za); title('Attractive Potential');
    % Normalization of Ja (only for better visualization)
    nablaJaXXn=nablaJaXX./sqrt(nablaJaXX.^2+nablaJaYY.^2);
    nablaJaYYn=nablaJaYY./sqrt(nablaJaXX.^2+nablaJaYY.^2);
    figure(); grid; quiver(XX,YY,-nablaJaXXn,-nablaJaYYn);
    title('Antigradient of Attractive Potential'); axis('equal');
    axis([goal(1)-15 goal(1)+15 goal(2)-15 goal(2)+15]);
    
    % REPULSIVE POTENTIAL
    Zr=zeros(size(Za));
    nablaJrXX=zeros(size(nablaJaXX));
    nablaJrYY=zeros(size(nablaJaXX));
    for i=1:size(O,1)
        oi=O(i,:);
        Zr=Zr+Jr(XX,YY,oi(1),oi(2)).*rho(XX,YY,oi(1),oi(2));
        nablaJrXX=nablaJrXX+nablaJrX(XX,YY,oi(1),oi(2)).*rho(XX,YY,...
                                                            oi(1),oi(2));
        nablaJrYY=nablaJrYY+nablaJrY(XX,YY,oi(1),oi(2)).*rho(XX,YY,...
                                                            oi(1),oi(2));
    end
    % Cancellation of the potential inside the obstacles
    for o=5:4:length(ostacoli)
        for i=1:length(XX)
            for j=1:length(YY)
                if (ostacoli(o,1)<XX(i,j) && XX(i,j)<ostacoli(o+1,1)) ...
                    && (ostacoli(o,2)<YY(i,j) && YY(i,j)<ostacoli(o+2,2))
                    nablaJaXX(i,j)=0;nablaJaYY(i,j)=0;
                    nablaJrXX(i,j)=0;nablaJrYY(i,j)=0;
                end
            end
        end
    end
    % Plot
    figure(); grid; surf(XX,YY,Zr); title('Repulsive Potential');
    % Normalization of Ja (only for better visualization)
    nablaJrXXn=nablaJrXX./sqrt(nablaJrXX.^2+nablaJrYY.^2);
    nablaJrYYn=nablaJrYY./sqrt(nablaJrXX.^2+nablaJrYY.^2);
    figure(); grid; quiver(XX,YY,-nablaJrXXn,-nablaJrYYn);
    title('Antigradient of Repulsive Potential'); axis('equal');
    axis([0 100 0 100]);
    
    % TOTAL POTENTIAL
    J=wa*Za+wo*Zr;
    nablaJx=wa*nablaJaXX+wo*nablaJrXX;
    nablaJy=wa*nablaJaYY+wo*nablaJrYY;
    
    % Normalization of J (only for better visualization)
    nablaJxn=nablaJx./sqrt(nablaJx.^2+nablaJy.^2);
    nablaJyn=nablaJy./sqrt(nablaJx.^2+nablaJy.^2);
    
    figure(); grid; surf(XX,YY,J); title('Total Potential');
    figure(); grid; quiver(XX,YY,-nablaJxn,-nablaJyn);
    title('Antigradient of Total Potential'); axis('equal');
    axis([0 100 0 100]);
    
    %% APF
    alpha=0.001;
    TH=0.2;
    nIter=10000;
    path=zeros(2,nIter);
    path(:,1)=X0;
    for k=2:nIter
        Xcur=path(:,k-1);
        nablaA=[
            nablaJaX(Xcur(1),Xcur(2),G(1),G(2));
            nablaJaY(Xcur(1),Xcur(2),G(1),G(2))
            ];
        nablaR=[0;0];
        for i=1:size(O,1)
            oi=O(i,:);
            nablaR=nablaR+[
                nablaJrX(Xcur(1),Xcur(2),oi(1),oi(2))*rho(Xcur(1),...
                                                    Xcur(2),oi(1),oi(2));
                nablaJrY(Xcur(1),Xcur(2),oi(1),oi(2))*rho(Xcur(1),...
                                                    Xcur(2),oi(1),oi(2));
                ];
        end
        nablaJ=wa*nablaA+wo*nablaR;
        Xsucc=Xcur-alpha*nablaJ;
        path(:,k)=Xsucc;
        if norm(Xsucc-G)<=TH
            break;
        end
    end
    if k<nIter
        path(:,k+1:end)=[];
    end
    
    % Plot
    path=path';
    figure(1); plot(path(:,1),path(:,2),'-','LineWidth',2); 
    title('Path using Artificial Potential Fields');legend('off');
end

