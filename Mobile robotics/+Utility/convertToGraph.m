function graphObj = convertToGraph(matriceDiAdiacenza, points)
    graphObj = graph(matriceDiAdiacenza, 'upper');
%CONVERT_TO_GRAPH
%   Function that constructs the graph from the adjacency matrix.
    
    % Imposta le etichette dei nodi del grafo
    numP = size(points, 1);
    labels = cellstr(num2str((1:numP)'));
    graphObj.Nodes.Name = labels;

    % Imposta le coordinate dei nodi del grafo
    X = points(:, 1);
    Y = points(:, 2);
    graphObj.Nodes.X = X;
    graphObj.Nodes.Y = Y;
end