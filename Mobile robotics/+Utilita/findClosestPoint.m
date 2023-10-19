function closestPoint = findClosestPoint(m, P)
%FIND_CLOSEST_POINT
%   Data una matrice Nx2 di punti del piano, restituisce il punto più
%   vicino a P tra tutti quelli presenti in m

    % Inizializza la distanza minima con un valore infinito
    closestDistance = Inf;
    % Inizializza il punto più vicino come vuoto
    closestPoint = [];

    for i = 1:size(m, 1)
        % Calcola la distanza euclidea tra il punto i-esimo di m e il 
        % punto P
        distance = norm(m(i, :) - P);

        % Se la distanza è minore della distanza minima attuale, aggiorna 
        % la distanza minima e il punto più vicino
        if distance < closestDistance
            closestDistance = distance;
            closestPoint = m(i, :);
        end
    end
end
