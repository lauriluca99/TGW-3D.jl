var documenterSearchIndex = {"docs":
[{"location":"README/","page":"LAR TGW 3D","title":"LAR TGW 3D","text":"(Image: CI) (Image: Documentation) (Image: Pages Build)","category":"page"},{"location":"README/#LAR-TGW-3D","page":"LAR TGW 3D","title":"LAR TGW 3D","text":"","category":"section"},{"location":"README/","page":"LAR TGW 3D","title":"LAR TGW 3D","text":"Progetto 8b del corso di Calcolo Parallelo e Distribuito erogato durante l'anno accademico 2021/2022 presso il Dipartimento di Ingegneria Informatica dell'Università Roma Tre.","category":"page"},{"location":"README/#Membri-del-team:","page":"LAR TGW 3D","title":"Membri del team:","text":"","category":"section"},{"location":"README/","page":"LAR TGW 3D","title":"LAR TGW 3D","text":"Luca Maria Lauricella","category":"page"},{"location":"README/","page":"LAR TGW 3D","title":"LAR TGW 3D","text":"Valerio Marini","category":"page"},{"location":"","page":"API Reference","title":"API Reference","text":"Modules = [TGW3D]\nOrder = [:module]","category":"page"},{"location":"#TGW3D.TGW3D","page":"API Reference","title":"TGW3D.TGW3D","text":"L’algoritmo Topological Gift Wrapping calcola le d-celle di una partizione di spazio generate da loro partendo da un oggetto geometrico d-1 dimensionale.\n\nTGW prende una matrice sparsa di dimensione d-1 in input e produce in output la matrice sparsa di dimensione d sconosciuta aumentata dalle celle esterne.\n\n\n\n\n\n","category":"module"},{"location":"#Riferimenti","page":"API Reference","title":"Riferimenti","text":"","category":"section"},{"location":"","page":"API Reference","title":"API Reference","text":"Questa pagina ha i riferimenti a tutti i tipi, metodi e funzioni utilizzati.","category":"page"},{"location":"#Tipi","page":"API Reference","title":"Tipi","text":"","category":"section"},{"location":"","page":"API Reference","title":"API Reference","text":"Modules = [TGW3D]\nOrder = [:type]","category":"page"},{"location":"#TGW3D.ChainOp","page":"API Reference","title":"TGW3D.ChainOp","text":"ChainOp = SparseArrays.SparseMatrixCSC{Int8,Int}\n\nDichiarazione Alias di specifiche strutture dati di LAR. SparseMatrix nel formato Colonne sparse compresse, contiene la rappresentazione in coordinate di un operatore tra lo spazio lineare delle P-chains. Operatori P-Boundary  P-Chain - (P-1)-Chain e P-Coboundary  P-Chain - (P+1)-Chain sono tipicamente immagazinati come ChainOpcon elementi in -101 oppure in 01, per operatori assegnati e non-assegnati rispettivamente.\n\n\n\n\n\n","category":"type"},{"location":"#TGW3D.Points","page":"API Reference","title":"TGW3D.Points","text":"Points = Array{Number,2}\n\nDichiarazione Alias di specifiche strutture dati di LAR. Array{Number,2,1} M x N compatto per immagazzinare la posizione dei vertici (0-cells) di un complesso cellulare. Il numero delle righe M è la dimensione  dello spazio di inclusione. Il numero delle colonne N è il numero dei vertici.\n\n\n\n\n\n","category":"type"},{"location":"#Funzioni","page":"API Reference","title":"Funzioni","text":"","category":"section"},{"location":"","page":"API Reference","title":"API Reference","text":"Modules = [TGW3D]\nOrder = [:function]","category":"page"},{"location":"#TGW3D.frag_face-NTuple{5, Any}","page":"API Reference","title":"TGW3D.frag_face","text":"function frag_face(\n        V::Points, \n        EV::ChainOp, \n        FE::ChainOp, \n        sp_idx::Vector{Int64}, \n        sigma::Int64)\n\nPrende la faccia sigma e la trasforma in 2D per poter calcolare le intersezioni con le facce in sp_idx[sigma] ed ottenere la disposizione 2D della faccia sigma.\n\n\n\n\n\n","category":"method"},{"location":"#TGW3D.frag_face_channel-Tuple{Any, Any, Matrix, Any, Any, Any}","page":"API Reference","title":"TGW3D.frag_face_channel","text":"function frag_face_channel(\n        in_chan, \n        out_chan, \n        V::Points, \n        EV::ChainOp, \n        FE::ChainOp, \n        sp_idx::Vector{Int64})\n\nFunzione che parallelizza, con l'utilizzo dei canali, la frammentazione delle facce in FE rispetto le facce in sp_idx.\n\n\n\n\n\n","category":"method"},{"location":"#TGW3D.merge_vertices","page":"API Reference","title":"TGW3D.merge_vertices","text":"function merge_vertices(\n        V::Points, \n        EV::ChainOp, \n        FE::ChainOp, \n        [err=1e-4])\n\nRimuove i vertici congruenti ad un singolo rappresentatante, traduce i lati per tener  conto della congruenza ed otteniene nuove facce congruenti.\n\nArgomenti addizionali:\n\nerr: Limite di errore massimo che si vuole utilizzare. Di Defaults a 1e-4.\n\n\n\n\n\n","category":"function"},{"location":"#TGW3D.removeinnerloops-Tuple{Any, Any}","page":"API Reference","title":"TGW3D.removeinnerloops","text":"function removeinnerloops(\n        g::Int64, \n        nFE::ChainOp)\n\nRimuove le facce all'interno dei cicli interni dalla matrice sparsa nFE. Il valore restituito ha g righe in meno rispetto all'input nFE.\n\n\n\n\n\n","category":"method"},{"location":"#TGW3D.spatial_arrangement","page":"API Reference","title":"TGW3D.spatial_arrangement","text":"function spatial_arrangement(\n        V::Points, \n        copEV::ChainOp, \n        copFE::ChainOp; \n        [multiproc::Bool])\n\nCalcola la disposizione sulle cellule complesse 2-skeleton date\tin 3D.\n\nUn complesso cellulare è disposto quando l'intersezione di ogni coppia di celle del complesso è vuota e l'unione di tutte le celle rappresenta l'intero spazio Euclideo. La funzione ritorna la piena disposizione complessa come una lista di vertici V e una catena di lati EV, FE, CF.\n\nArgomenti addizionali:\n\nmultiproc::Bool: Esegue la computazione in modalità parallela. Di Defaults a false.\n\n\n\n\n\n","category":"function"},{"location":"#TGW3D.spatial_arrangement_1","page":"API Reference","title":"TGW3D.spatial_arrangement_1","text":"function spatial_arrangement_1(\n        V::Points,\n        copEV::ChainOp,\n        copFE::ChainOp, \n        [multiproc::Bool=false])\n\nSi occupa del processo di frammentazione delle facce per l'utilizzo del planar arrangement.\t Richiama le funzioni frag_face e `merge_vertices' per ritornare i nuovi vertici, lati e facce.\n\nArgomenti addizionali:\n\nmultiproc::Bool: Esegue la computazione in modalità parallela. Di Defaults a false.\n\n\n\n\n\n","category":"function"},{"location":"#TGW3D.spatial_arrangement_2","page":"API Reference","title":"TGW3D.spatial_arrangement_2","text":"function spatial_arrangement_2(\n        rV::Points, \n        rcopEV::ChainOp, \n        rcopFE::ChainOp, \n        [multiproc::Bool=false])\n\nEffettua la ricostruzione delle facce permettendo il wrapping spaziale 3D.\n\nArgomenti addizionali:\n\nmultiproc::Bool: Esegue la computazione in modalità parallela. Di Defaults a false.\n\n\n\n\n\n","category":"function"}]
}
