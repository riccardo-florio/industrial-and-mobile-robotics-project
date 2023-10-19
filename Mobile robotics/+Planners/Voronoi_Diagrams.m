function [path] = Voronoi_Diagrams(start,goal,stanza,ostacoli)
%VORONOI_DIAGRAMS
%   Calcola il percorso utilizzando il metodo del diagramma di Vroronoi
    
    % Estrazione dei punti del diagramma di Voronoi
    [x,y] = voronoi(stanza(:,1),stanza(:,2));
    
    % Plot del diagramma
    figure(1); plot(x, y, 'Color', '#4DBEEE'); axis([-5 105 -5 105]);
    title('Percorso con Diagramma di Voronoi');
    
    
    %% Rimozione dei punti interni agli ostacoli ed esterni alla stanza
    i=0;
    while i<size(x,2)
        i=i+1;
        P2=[x(1,i) y(1,i)];
        P1=[x(2,i) y(2,i)];
        for o=5:4:length(ostacoli)
            if (ostacoli(o,1)<P1(1) && P1(1)<ostacoli(o+1,1) && ...
                ostacoli(o,2)<P1(2) && P1(2)<ostacoli(o+2,2)) || ...
                (ostacoli(o,1)<P2(1) && P2(1)<ostacoli(o+1,1) && ...
                ostacoli(o,2)<P2(2) && P2(2)<ostacoli(o+2,2)) || ...
                (P1(1)<ostacoli(1,1) || P1(1)>ostacoli(2,1) || ...
                P1(2)<ostacoli(1,2) || P1(2)>ostacoli(3,2) || ...
                P2(1)<ostacoli(1,1) || P2(1)>ostacoli(2,1) || ...
                P2(2)<ostacoli(1,2) || P2(2)>ostacoli(3,2)) || ...
                (P1(1)==P2(1) && P1(2)==P2(2))

                x(:,i)=[];
                y(:,i)=[];
                i=i-1;
                break
            end
        end
    end
    
    %% Aggiunta dei punti di start e goal nel diagramma
    % Individuazione dei punti piu' vicini a start e goal
    m=[x(1,:)' y(1,:)'; x(2,:)' y(2,:)'];
    closestS = Utilita.findClosestPoint(m,start);
    closestG = Utilita.findClosestPoint(m,goal);
    % Inserimento nel diagramma
    x=[x, [closestS(1);start(1)], [closestG(1);goal(1)]];
    y=[y, [closestS(2);start(2)], [closestG(2);goal(2)]];
    
    figure(1); plot(x, y,'LineWidth',1,'Color','#A2142F');
    
    %% Grafo
    % Inserimento in un unico vettore di tutti i punti del diagramma in 
    % modo che ogni coppia v(i,:),v(i+1,:) con i=i+2 rappresenta un
    % collegamento nel giagramma
    v=zeros(2*length(x),2);j=1;
    for i=1:2:length(v)-1
            v(i,:)=[x(2,j),y(2,j)];
            j=j+1;
    end
    j=1;
    for i=2:2:length(v)
            v(i,:)=[x(1,j),y(1,j)];
            j=j+1;
    end
    
    % Creazione di un indice dei punti del diagramma
    indice=unique(v, 'rows');
    
    % Creazione del grafo
    g=graph();
    g=addnode(g,size(indice,1));
    
    % Aggiunta degli archi in maniera appropriata al grafo usando l'indice
    % Sapendo che ogni coppia v(i,:),v(i+1,:) con i=i+2 rappresenta un
    % collegamento nel giagramma, si puo' costruire il grafo secondo
    % questo principio
    for i=1:2:length(v)-1
        ig1=Utilita.trovaIndiceRiga(indice,v(i,:));
        ig2=Utilita.trovaIndiceRiga(indice,v(i+1,:));
        g=addedge(g,ig1,ig2);
    end
    
%     figure; plot(g)
    
    % Percorso minimo
    is=Utilita.trovaIndiceRiga(indice,start);
    ig=Utilita.trovaIndiceRiga(indice,goal);
    percorsoMinimo = shortestpath(g,is,ig);
    
    path = indice(percorsoMinimo, :);
    
    % Aggiunta dei punti mancanti tra due distanti piu' di 1,5
    i=0;
    while i<size(path,1)-1
        i=i+1;
        distanza = round(sqrt((path(i+1,1) - path(i,1))^2 + ...
            (path(i+1,2) - path(i,2))^2));
        if distanza>1.5
            ptemp1=path(1:i-1,:);
            ptemp2=path(i+2:end,:);
            xd=linspace(path(i,1),path(i+1,1),distanza+1);
            yd=linspace(path(i,2),path(i+1,2),distanza+1);
            path=[ptemp1; xd',yd'; ptemp2];
        end
    end
    
    plot(path(:,1),path(:,2),'-','LineWidth',2,'Color','#EDB120');
    legend('off');
end
