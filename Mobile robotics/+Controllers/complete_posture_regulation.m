function Xdot = complete_posture_regulation(t, X, X_star,k1,k2,k3)
%COMPLETE_POSTURE_REGULATION
%   Implementa la legge di controllo che si occupa di ricavare i segnali v
%   e w di controllo del robot necessari per poterlo portare nella posa di
%   goal. Dopodiche' li applica al modello uniciclo.

    x=X(1);
    y=X(2);
    theta=X(3);
    
    x_star=X_star(1);
    y_star=X_star(2);
    theta_star=X_star(3);
    
    ex=x_star-x;
    ey=y_star-y;
    etheta=Utilita.delta_angle(theta_star,theta);
    
    rho=norm([ex;ey]);
    gamma=Utilita.delta_angle(atan2(ey,ex),theta);
    delta=Utilita.delta_angle(gamma,etheta);
    
    v=k1*rho*cos(gamma);
    w=k2*gamma+k1*(sin(gamma)*cos(gamma)/gamma)*(gamma+k3*delta);
    
    Xdot=[
        v*cos(theta);
        v*sin(theta);
        w
        ];

end

