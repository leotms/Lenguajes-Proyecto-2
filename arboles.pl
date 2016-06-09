% Arboles como estructura.

nodo(Etiqueta,[]) :- integer(Etiqueta).
nodo(Etiqueta,[X|Y]) :- integer(Etiqueta).