% Arboles como estructura.

nodo(Etiqueta,[]) :- integer(Etiqueta).
nodo(Etiqueta,[X|Y]) :- integer(Etiqueta), .


% Predicado que indica si los nodos de un arbol estan bien etiquetados.

bienEtiquetado(+Arbol). 
bienEtiquetado(nodo(Etiqueta,[])).
bienEtiquetado(nodo(Etiqueta,[X|Y])) :-  
