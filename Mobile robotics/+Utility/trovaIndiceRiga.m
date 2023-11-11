function indiceRiga = trovaIndiceRiga(matrice, rigaDaCercare)
% FIND_ROW_INDEX
%   Returns the index of the input row. Returns -1 if the row is not
%   present in the matrix.

    for i=1:size(matrice,1)
        if matrice(i,:)==rigaDaCercare
            indiceRiga=i;
            return
        end
    end
    indiceRiga=-1;
end
