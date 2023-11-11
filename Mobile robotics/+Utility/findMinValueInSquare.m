function [minValue, minX, minY] = findMinValueInSquare(matrix, x, y, s)
%FIND_MINVALUE_IN_SQUARE
%   Returns the coordinates of the minimum value among those in the square
%   surrounding the point (x, y) in the matrix 'matrix'.
%   matrix = nxm matrix
%   x, y = coordinates of the point
%   s = size of the circumscribed square

    [rows, cols] = size(matrix);
    
    % Computes the start and end indices for the circumscribed square
    startRow = max(1, x - floor(s/2));
    endRow = min(rows, x + ceil(s/2) - 1);
    startCol = max(1, y - floor(s/2));
    endCol = min(cols, y + ceil(s/2) - 1);
    
    % Initializes the minimum value with the first element in the square
    minValue = matrix(startRow, startCol);
    minX = startRow;
    minY = startCol;
    
    % Searches for the minimum value within the square
    for i = startRow:endRow
        for j = startCol:endCol
            if matrix(i, j) < minValue
                minValue = matrix(i, j);
                minX = i;
                minY = j;
            end
        end
    end
    
end

