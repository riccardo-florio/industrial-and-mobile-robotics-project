function [dAngle] = delta_angle(theta1,theta2)
% DELTA_ANGLE
%   Computes the angular difference considering that angles are periodic.
    
    dAngle = atan2(sin(theta1-theta2),cos(theta1-theta2));
    
end

