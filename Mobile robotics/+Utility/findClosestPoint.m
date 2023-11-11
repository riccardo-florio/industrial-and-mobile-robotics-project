function closestPoint = findClosestPoint(m, P)
%FIND_CLOSEST_POINT
%   Given an Nx2 matrix of points in the plane, returns the point closest
%   to P among all those in m.

    % Initialize the minimum distance with an infinite value
    closestDistance = Inf;
    % Initialize the nearest point as empty
    closestPoint = [];

    for i = 1:size(m, 1)
        % Computes the Euclidean distance between the i-th point in m and
        % point P
        distance = norm(m(i, :) - P);

        % If the distance is less than the current minimum distance, update
        % the minimum distance and the nearest point
        if distance < closestDistance
            closestDistance = distance;
            closestPoint = m(i, :);
        end
    end
end
