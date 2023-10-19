function [dAngle] = delta_angle(theta1,theta2)
%DELTA_ANGLE
%   Calcola la differenza angolare tenendo conto del fatto che gli angoli
%   sono periodici
    
    dAngle = atan2(sin(theta1-theta2),cos(theta1-theta2));
    
end

