% Plot della stanza con gli ostacoli "ingrassati" di 5 (raggio del robot) +
% il 10% del raggio

% Dati della stanza e degli ostacoli
roomWidth = 100;  % Larghezza della stanza
roomHeight = 80;  % Altezza della stanza
robotRadius = 5;  % Raggio del robot
obstacleRadius = 10;  % Raggio degli ostacoli
obstaclePositions = [30, 40; 70, 60];  % Posizioni degli ostacoli

% Creazione della figura
figure;

% Disegno della stanza
rectangle('Position', [0, 0, roomWidth, roomHeight], 'EdgeColor', 'k', 'LineWidth', 2);
hold on;

% Disegno degli ostacoli "ingrassati" usando rettangoli approssimati
for i = 1:size(obstaclePositions, 1)
    obstacleX = obstaclePositions(i, 1);
    obstacleY = obstaclePositions(i, 2);
    thickenedRadius = robotRadius + 0.1 * robotRadius;  % Aggiunta del 10% del raggio
    
    % Calcolo delle posizioni del rettangolo approssimato
    rectX = obstacleX - obstacleRadius - thickenedRadius;
    rectY = obstacleY - obstacleRadius - thickenedRadius;
    rectWidth = 2 * (obstacleRadius + thickenedRadius);
    rectHeight = 2 * (obstacleRadius + thickenedRadius);
    
    % Disegno del rettangolo
    rectangle('Position', [rectX, rectY, rectWidth, rectHeight], 'Curvature', [1, 1], 'EdgeColor', 'r', 'LineWidth', 1.5);
end

% Disegno del robot
robotPosition = [10, 20];  % Posizione del robot (cambia questa posizione secondo necessità)
rectangle('Position', [robotPosition(1) - robotRadius, robotPosition(2) - robotRadius, 2 * robotRadius, 2 * robotRadius], ...
    'Curvature', [1, 1], 'EdgeColor', 'b', 'LineWidth', 2);

% Impostazione dell'aspetto della figura
axis equal;
grid on;
xlabel('X-axis');
ylabel('Y-axis');
title('Room with Thickened Obstacles and Robot');

% Legenda
legend('Room', 'Thickened Obstacles', 'Robot');

% Mostrare la griglia e la legenda
grid on;
legend show;

% Facoltativo: salvare l'immagine
% saveas(gcf, 'room_plot.png');
