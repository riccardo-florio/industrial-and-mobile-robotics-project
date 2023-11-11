function [path] = Voronoi_Diagrams(start,goal,room,ostacoli)
%VORONOI_DIAGRAMS
%   Calculate the path using the Voronoi diagram method
    
    % Extraction of the points of the Voronoi diagram
    [x,y] = voronoi(room(:,1),room(:,2));
    
    % Plot of the diagram
    figure(1); plot(x, y, 'Color', '#4DBEEE'); axis([-5 105 -5 105]);
    title('Path with Voronoi Diagram');
    
    
    %% Removal of points inside obstacles and outside the room
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
    
    %% Add start and goal points to the diagram
    % Find the points closest to the start and goal
    m=[x(1,:)' y(1,:)'; x(2,:)' y(2,:)'];
    closestS = Utility.findClosestPoint(m,start);
    closestG = Utility.findClosestPoint(m,goal);
    % Insert into the diagram
    x=[x, [closestS(1);start(1)], [closestG(1);goal(1)]];
    y=[y, [closestS(2);start(2)], [closestG(2);goal(2)]];
    
    figure(1); plot(x, y,'LineWidth',1,'Color','#A2142F');
    
    %% Graph
    % Place all diagram points into a single vector, where each 
    % pair v(i, :), v(i+1, :) with i=i+2 represents a connection 
    % in the diagram
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
    
    % Create an index for diagram points
    indice=unique(v, 'rows');
    
    % Create the graph
    g=graph();
    g=addnode(g,size(indice,1));
    
    % Add edges appropriately to the graph using the index
    % Knowing that each pair v(i, :), v(i+1, :) with i=i+2 represents 
    % a connection in the diagram, we can build the graph based on 
    % this principle
    for i=1:2:length(v)-1
        ig1=Utility.trovaIndiceRiga(indice,v(i,:));
        ig2=Utility.trovaIndiceRiga(indice,v(i+1,:));
        g=addedge(g,ig1,ig2);
    end
    
%     figure; plot(g)
    
    % Minimum path
    is=Utility.trovaIndiceRiga(indice,start);
    ig=Utility.trovaIndiceRiga(indice,goal);
    percorsoMinimo = shortestpath(g,is,ig);
    
    path = indice(percorsoMinimo, :);
    
    % Add missing points between two points more than 1.5 units apart
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