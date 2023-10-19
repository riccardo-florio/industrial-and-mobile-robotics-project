function Xdot = robot_control_FL(t,X, ...
    x_star,y_star, ...
    xd_star,yd_star, ...
    kx,ky,b)

%CONTROLLO BASATO SU FEEDBACK LINEARIZATION
%   Si occupa di ricavare i segnali di comando v e w del robot utilizzando
%   il metodo dell'Input-Output Linearization. Dopodiche' li applica al 
%   modello uniciclo.

    x=X(1);
    y=X(2);
    theta=X(3);

    xB=x+b*cos(theta);
    yB=y+b*sin(theta);

    xstar=x_star(t);
    ystar=y_star(t);

    xBdotstar=xd_star(t);
    yBdotstar=yd_star(t);

    Tinv=[
        cos(theta)    sin(theta);
        -sin(theta)/b cos(theta)/b
        ];

    ux=xBdotstar+kx*(xstar-xB);
    uy=yBdotstar+ky*(ystar-yB);

    vw=Tinv*[ux;uy];
    v=vw(1);
    w=vw(2);

    Xdot=[
        v*cos(theta);
        v*sin(theta);
        w
        ];

end

