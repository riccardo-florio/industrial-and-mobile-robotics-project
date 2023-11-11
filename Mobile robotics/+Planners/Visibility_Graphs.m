function [path] = Visibility_Graphs(start, goal, obstacles)
% VISIBILITY_GRAPHS
%   Calculates the path using the visibility graph method

    % Removal of the room boundaries from the list of obstacles and
    % addition of the start and goal points
    boundaries = obstacles(5:end, :);
    boundaries = [start; boundaries; goal];
    
    % Creation of the adjacency matrix
    numPoints = size(boundaries, 1);
    adjacencyMatrix = zeros(numPoints, numPoints);
    for i = 1:numPoints
        for j = i+1:numPoints
            if Utility.isVisible(boundaries(i, :), boundaries(j, :), obstacles)
                adjacencyMatrix(i, j) = 1;
                adjacencyMatrix(j, i) = 1;
            end
        end
    end
    
    % Creation of the graph
    graph = Utility.convertToGraph(adjacencyMatrix, boundaries);
    
    % Plot of the graph
    plot(graph, 'XData', graph.Nodes.X, 'YData', graph.Nodes.Y, ...
        'NodeLabel', graph.Nodes.Name);
    
    % Identification of the minimum path in the graph
    shortestPath = shortestpath(graph, 1, numPoints);
    
    % Discretization of the minimum path
    numNodes = length(shortestPath);
    path = [];
    for i = 1:numNodes - 1
        node1 = shortestPath(i);
        node2 = shortestPath(i+1);
        % Discretization of the path between two nodes
        x = linspace(graph.Nodes.X(node1), graph.Nodes.X(node2), 50);
        y = linspace(graph.Nodes.Y(node1), graph.Nodes.Y(node2), 50);
        for j = 1:length(x) - 1
            path = [path; x(j) y(j)];
        end
    end
    path = [path; graph.Nodes.X(numPoints) graph.Nodes.Y(numPoints)];
    
    % Plot of the final path
    plot(path(:, 1), path(:, 2), '-', 'LineWidth', 2);
    title('Path with Visibility Graph'); legend('off');
end
