function [path] = Discrete_Potential_Fields(start, goal, obstacles)
% Discrete_Potential_Fields
%   Calculates the path using the Discrete Potential Fields method

    n = obstacles(2,1) - obstacles(1,1); % Number of rows in the matrix
    m = obstacles(3,2) - obstacles(2,2); % Number of columns in the matrix
    xG = goal(1); % x-coordinate of the goal point
    yG = goal(2); % y-coordinate of the goal point

    %% DISCRETE POTENTIAL APPROXIMATION
    % Matrix with all values set to -1
    grid = zeros(n, m);
    for i = 1:n
        for j = 1:m
            grid(i, j) = -1;
        end
    end

    % 0 at the goal
    grid(xG, yG) = 0;

    for k = 1:m * n
        for i = 1:n
            for j = 1:m
                if grid(i, j) == k - 1
                    % nw
                    if i - 1 > 0 && j - 1 > 0 && grid(i - 1, j - 1) == -1
                        grid(i - 1, j - 1) = k;
                    end
                    % n
                    if i - 1 > 0 && grid(i - 1, j) == -1
                        grid(i - 1, j) = k;
                    end
                    % ne
                    if i - 1 > 0 && j + 1 < m + 1 && grid(i - 1, j + 1) == -1
                        grid(i - 1, j + 1) = k;
                    end
                    % e
                    if j + 1 < m + 1 && grid(i, j + 1) == -1
                        grid(i, j + 1) = k;
                    end
                    % se
                    if i + 1 < n + 1 && j + 1 < m + 1 && grid(i + 1, j + 1) == -1
                        grid(i + 1, j + 1) = k;
                    end
                    % s
                    if i + 1 < n + 1 && grid(i + 1, j) == -1
                        grid(i + 1, j) = k;
                    end
                    % sw
                    if i + 1 < n + 1 && j - 1 > 0 && grid(i + 1, j - 1) == -1
                        grid(i + 1, j - 1) = k;
                    end
                    % w
                    if j - 1 > 0 && grid(i, j - 1) == -1
                        grid(i, j - 1) = k;
                    end
                end
            end
        end
    end

    % Remove obstacles
    for o = 5:4:length(obstacles)
        for i = 1:n
            for j = 1:m
                if j >= obstacles(o, 1) && j <= obstacles(o + 1, 1) && ...
                    i >= obstacles(o + 1, 2) && i <= obstacles(o + 2, 2)
                    grid(j, i) = inf;
                end
            end
        end
    end

    % Remove room borders
    grid(1, :) = inf;
    grid(:, 1) = inf;
    grid(n, :) = inf;
    grid(:, m) = inf;

    % Plot
    [X, Y] = meshgrid(linspace(0, n, m), linspace(0, n, m));
    figure();
    mesh(Y, X, grid);
    axis equal;
    title('Discrete Potential Approximation');
    xlabel('x');
    ylabel('y');
    zlabel('z');
    
    %% PATH CALCULATION
    path = start;
    PC = start;
    for i = 1:n * m
        if PC == goal
            figure(1);
            plot(path(:, 1), path(:, 2), '-', 'LineWidth', 2);
            title('Path with Discrete Potential Fields');
            legend('off');
            return
        end
        
        [minValue, minX, minY] = Utility.findMinValueInSquare(grid, ...
            PC(1), PC(2), 3);
        
        if minValue < grid(PC(1), PC(2))
            path = [path; minX minY];
        end
        
        if minValue == grid(PC(1), PC(2))
            % For each cell one step from minX, minY, find the one that has
            % not been visited yet
            
            % Definition of offsets for the eight one-step cells
            offsets = [-1, -1; -1, 0; -1, 1; 0, -1; 0, 1; 1, -1; 1, 0; 1, 1];

            % Iterate through the eight one-step cells
            for j = 1:size(offsets, 1)
                newRow = PC(1) + offsets(j, 1);
                newCol = PC(2) + offsets(j, 2);
                
                cellValue = grid(newRow, newCol);
                
                if cellValue == minValue
                    alreadyVisited = false;
                    for ics = 1:size(path, 1)
                        if path(ics, :) == [newRow newCol]
                            alreadyVisited = true;
                        end
                    end
                    if alreadyVisited == false
                        path = [path; newRow newCol];
                        break
                    end
                end
                if j == size(offsets, 1)
                     % If we reach this point, it means no available cell was
                     % found, so we need to backtrack
                    
                     % Determine along which axis we are moving
                     if path(end, 1) == path(end - 1, 1)
                         % Moving along the y-axis
                         pos = size(path, 1);
                         prev = [0 0];
                         while pos - 1 > 0 && path(pos, 1) == path(pos - 1, 1)
                             prev = path(pos, :);
                             path(pos, :) = [];
                             pos = pos - 1;
                         end
                         if path(pos, 2) > prev(2)
                             path = [path; path(pos, 1) path(pos, 2) + 1];
                         else
                             path = [path; path(pos, 1) path(pos, 2) - 1];
                         end
                     elseif path(end, 2) == path(end - 1, 2)
                         % Moving along the x-axis
                         pos = size(path, 1);
                         prev = [0 0];
                         while pos - 1 > 0 && path(pos, 2) == path(pos - 1, 2)
                             prev = path(pos, :);
                             path(pos, :) = [];
                             pos = pos - 1;
                         end
                         if path(pos, 1) > prev(1)
                             path = [path; path(pos, 1) + 1 path(pos, 2)];
                         else
                             path = [path; path(pos, 1) - 1 path(pos, 2)];
                         end
                     end
                end
            end
        end
        
        PC = path(end, :);
        
    end
    
    %% Plot
    % This plot occurs only if the function ends without finding a path
    % from the start point to the goal point
    figure(1);
    plot(path(:, 1), path(:, 2), '-', 'LineWidth', 2);
    title('Path with Discrete Potential Fields');
    legend('off');
end
