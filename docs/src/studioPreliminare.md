# Studio Preliminare

## spatial_arrangement.jl
L'algoritmo TGW 3D è implementato all'interno del file spatial_arrangement.jl

![Grafo delle Dipendenze di spatial_arrangement.jl](assets/image3.png)

### Funzioni presenti



#### **spatial\_arrangement:**

Calcola la partizione dei complessi cellulari dati, con scheletro di
dimensione 2, in 3D.

Un complesso cellulare è partizionato quando l’intersezione di ogni
possibile paio di celle del complesso è vuota e l’unione di tutte le
celle è l’insieme dello spazio Euclideo. La funzione ritorna la
partizione complessa come una lista di vertici V e una catena di bordi
EV, FE, CF.

#### *spatial\_arrangement\_1:*

Si occupa del processo di frammentazione delle facce per l’utilizzo del
planar arrangement.

1.  compute\_FV:

> Ritorna l’array FV di tipo Lar.Cells dal prodotto di due array sparsi
> in input di tipo Lar.ChainOp.

2.  spaceindex:

> Dato un modello geometrico, calcola le intersezioni tra i bounding
> box. Nello specifico, la funzione calcola le 1-celle e il loro
> bounding box attraverso la funzione boundingBox. Si suddividono le
> coordinate *x* e *y* in due dizionari chiamando la funzione
> coordintervals. Per entrambe le coordinate *x* e *y*, si calcola un
> intervalTree cioè una struttura dati che contiene intervalli. La
> funzione boxCovering viene chiamata per calcolare le sovrapposizioni
> sulle singole dimensioni dei bounding Box. Intersecando quest’ultime,
> si ottengono le intersezioni effettive tra bounding box. La funzione
> esegue lo stesso procedimento sulla coordinata *z* se presente.
> Infine, si eliminano le intersezioni di ogni bounding box con loro
> stessi.

3.  frag\_face:

> Effettua la trasformazione in 2D delle facce fornite come parametro
> sigma, dopo di che ogni faccia sigma si interseca con le facce
> Presenti in sp\_index sempre fornito come parametro della funzione.

4.  skel\_merge:

> Effettua l’unione di due scheletri che possono avere 1 o 2 dimensioni.

5.  merge\_vertices:

> Effettua l’unione dei vertici, dei lati e delle facce vicine.

#### *biconnected\_components:*

Calcola le componenti biconnesse del grafo EV rappresenato da bordi,
ovvero coppie di vertici.

1.  an\_edge:

> Funzione che, dato in input un punto, prende un lato connesso ad esso.

2.  get\_head:

> Funzione che, dato in input un lato e la coda, fornisce la testa

3.  v\_to\_vi:

> Funzione che, dato un vertice in input, ritorna falso se la prima
> occerrenza della matrice è pari a 0 oppure ritorna il valore trovato.

4.  push!:

> Inserisce uno o più oggetti nella matrice.

5.  pop!:

> Rimuove l’ultimo oggetto nella matrice e lo ritorna.

6.  sort:

> Ordina la matrice e ne ritorna una copia.

#### *spatial\_arrangement\_2:*

Effettua la ricostruzione delle facce permettendo il wrapping spaziale
3D.

1.  minimal\_3cycles:

> Funzione che riporta i parametri dati in input in 3 dimensioni e
> calcola le nuove celle adiacenti per estendere i bordi della figura
> geometrica. Infine ritorna la matrice sparsa tridimensionale.

2.  build\_copFC:

> Funzione alternativa alla precedente.
