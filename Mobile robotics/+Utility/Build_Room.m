function [room] = Build_Room(vertices)
%Build_Room
%   Given the set of vertices composing the room and the obstacles,
%   it returns the set of points forming the sides of the obstacles
%   using a unit sampling step.

    room=[];
    for i=1:4:length(vertices)
        % lato inferiore
        for j=vertices(i,1):vertices(i+1,1)
            room=[room; j vertices(i,2)];
        end
        % lato superiore
        for j=vertices(i+2,1):vertices(i+3,1)
            room=[room; j vertices(i+3,2)];
        end
        % lato sinistro
        for j=vertices(i+1,2):vertices(i+2,2)
            room=[room; vertices(i,1) j];
        end
        % lato destro
        for j=vertices(i+1,2):vertices(i+2,2)
            room=[room; vertices(i+3,1) j];
        end
    end
    
end

