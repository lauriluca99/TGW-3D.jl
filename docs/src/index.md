```@autodocs
Modules = [TGW3D]
Order = [:module]
```

# Riferimenti

Questa pagina ha i riferimenti a tutti i tipi, metodi e funzioni utilizzati.

## Tipi

```@autodocs
Modules = [TGW3D]
Order = [:type]
```

## Funzioni

Dati utilizzati per l'esecuzione degli esempi:

```julia
using SparseArrays
V = Float64[
        0 0 0; 0 1 0;
        1 1 0; 1 0 0;
        0 0 1; 0 1 1;
        1 1 1; 1 0 1
]

EV = sparse(Int8[
        -1  1  0  0  0  0  0  0;
        0 -1  1  0  0  0  0  0;
        0  0 -1  1  0  0  0  0;
        -1  0  0  1  0  0  0  0;
        -1  0  0  0  1  0  0  0;
        0 -1  0  0  0  1  0  0;
        0  0 -1  0  0  0  1  0;
        0  0  0 -1  0  0  0  1;
        0  0  0  0 -1  1  0  0;
        0  0  0  0  0 -1  1  0;
        0  0  0  0  0  0 -1  1;
        0  0  0  0 -1  0  0  1;
])

FE = sparse(Int8[
        1  1  1 -1  0  0  0  0  0  0  0  0;
        0  0  0  0  0  0  0  0 -1 -1 -1  1;
        -1  0  0  0  1 -1  0  0  1  0  0  0;
        0 -1  0  0  0  1 -1  0  0  1  0  0;
        0  0 -1  0  0  0  1 -1  0  0  1  0;
        0  0  0  1 -1  0  0  1  0  0  0 -1;
])
```


```@autodocs
Modules = [TGW3D]
Order = [:function]
```
