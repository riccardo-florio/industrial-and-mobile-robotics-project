function [path] = Visibility_Graphs(start,goal,ostacoli)
%VISIBILITY_GRAPHS
%   Calcola il percorso utilizzando il metodo dei grafi di visibilita'
    
    % Rimozione degli estremi della stanza dalla lista degli ostacoli ed
    % aggiunta dei punti di start e goal
    estremi = ostacoli(5:end,:);
    estremi = [start; estremi; goal];
    
    % Creazione della matrice di adiacenza
    numPunti = size(estremi, 1);
    matriceDiAdiacenza = zeros(numPunti, numPunti);
    for i = 1:numPunti
        for j = i+1:numPunti
            if Utilita.isVisible(estremi(i, :), estremi(j, :), ostacoli)
                matriceDiAdiacenza(i, j) = 1;
                matriceDiAdiacenza(j, i) = 1;
            end
        end
    end
    
    % Creazione del grafo
    grafo = Utilita.convertToGraph(matriceDiAdiacenza, estremi);
    
    % Plot del grafo
    plot(grafo, 'XData', grafo.Nodes.X, 'YData', grafo.Nodes.Y, ...
        'NodeLabel', grafo.Nodes.Name);
    
    % Individuazione del percorso minimo nel grafo
    percorsoMinimo = shortestpath(grafo,1,numPunti);
    
    % Discretizzazione del percorso minimo
    numNodi = length(percorsoMinimo);
    path=[];
    for i = 1:numNodi-1
        pi1 = percorsoMinimo(i);
        pi2 = percorsoMinimo(i+1);
        % Discretizzazione del percorso tra due nodi
        x=linspace(grafo.Nodes.X(pi1),grafo.Nodes.X(pi2),50);
        y=linspace(grafo.Nodes.Y(pi1),grafo.Nodes.Y(pi2),50);
        for j=1:length(x)-1
            path=[path; x(j) y(j)];
        end
    end
    path=[path; grafo.Nodes.X(numPunti) grafo.Nodes.Y(numPunti)];
    
    % Plot del percorso finale
    plot(path(:,1),path(:,2),'-','LineWidth',2);
    title('Percorso con Grafo di Visibilità');legend('off');
end

