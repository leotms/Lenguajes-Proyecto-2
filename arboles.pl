% Arboles como estructura.

nodo(E,L).
arista(E1,nodo(E2,L)).
nodo(Etiqueta,[]).
nodo(Etiqueta,[X|Y]).