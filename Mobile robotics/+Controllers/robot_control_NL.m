function Xdot = robot_control_NL(t,X, ...
    x_star,y_star,theta_star, ...
    xd_star,yd_star, ...
    xdd_star,ydd_star, ...
    k1,k2,k3)

%CONTROLLO NON LINEARIZZATO
%   Si occupa di ricavare i segnali di comando v e w del robot utilizzando 
%   un controllore non lineare. Dopodiche' li applica al modello uniciclo.

    x=X(1);
    y=X(2);
    theta=X(3);

    xstar=x_star(t);
    ystar=y_star(t);
    thetastar=theta_star(t);

    xdotstar=xd_star(t);
    ydotstar=yd_star(t);

    xddotstar=xdd_star(t);
    yddotstar=ydd_star(t);

    vstar=sqrt(xdotstar^2+ydotstar^2);
    wstar=(yddotstar*xdotstar-ydotstar*xddotstar)/(vstar^2);

    ex=cos(theta)*(xstar-x)+sin(theta)*(ystar-y);
    ey=-sin(theta)*(xstar-x)+cos(theta)*(ystar-y);
    etheta=Utilita.delta_angle(thetastar,theta);

    ux=-k1(vstar,wstar)*ex;
    uy=-k2*vstar*(sin(etheta)/etheta)*ey-k3(vstar,wstar)*etheta;

    v=vstar*cos(etheta)-ux;
    w=wstar-uy;

    Xdot=[
        v*cos(theta);
        v*sin(theta);
        w
        ];
end

