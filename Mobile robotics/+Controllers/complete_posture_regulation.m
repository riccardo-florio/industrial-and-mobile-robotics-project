function Xdot = complete_posture_regulation(t, X, X_star,k1,k2,k3)
% COMPLETE_POSTURE_REGULATION
%   Implements the control law that obtains the control signals v and w
%   necessary to bring the robot to the goal pose. Afterwards, it applies
%   them to the unicycle model.

    x=X(1);
    y=X(2);
    theta=X(3);
    
    x_star=X_star(1);
    y_star=X_star(2);
    theta_star=X_star(3);
    
    ex=x_star-x;
    ey=y_star-y;
    etheta=Utility.delta_angle(theta_star,theta);
    
    rho=norm([ex;ey]);
    gamma=Utility.delta_angle(atan2(ey,ex),theta);
    delta=Utility.delta_angle(gamma,etheta);
    
    v=k1*rho*cos(gamma);
    w=k2*gamma+k1*(sin(gamma)*cos(gamma)/gamma)*(gamma+k3*delta);
    
    Xdot=[
        v*cos(theta);
        v*sin(theta);
        w
        ];

end

