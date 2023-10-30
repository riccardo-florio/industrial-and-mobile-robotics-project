function indiceRiga = trovaIndiceRiga(matrice, rigaDaCercare)
%TROVA_INDICE_RIGA 
%   Restituisce l'indice della rica passata in input. Restituisce -1 se
%   la riga non e' presente nella matrice

    for i=1:size(matrice,1)
        if matrice(i,:)==rigaDaCercare
            indiceRiga=i;
            return
        end
    end
    indiceRiga=-1;
end
