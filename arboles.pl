% Autores:
% Aldrix Marfil     10-10940.
% Leonardo Martinez 11-10576.

% Arboles como Estructuras
% nodo(Etiqueta,[]) :- integer(Etiqueta).
% nodo(Etiqueta,[X|Y]) :- integer(Etiqueta).
% arista(Etiqueta, Nodo) :- integer(Etiqueta) , nodo(Nodo).

esVacia([]).

noEstaEnLaLista(X,[Y|Z]) :- integer(X), integer(Y), esVacia(Z), X =\= Y.
noEstaEnLaLista(X,[Y|Z]) :- integer(X), integer(Y), X =\= Y, noEstaEnLaLista(X,Z).

insertarEnLaLista(X,Y,[X]) :- esVacia(Y).
insertarEnLaLista(X,Y,[X|Y]) :- noEstaEnLaLista(X,Y).


% ----------------------------- bienEtiquetado --------------------------------
% Predicado que indica si los nodos de un arbol estan bien etiquetados.

bienEtiquetado2(nodo(E,X),L1,L2) :- integer(E), esVacia(X), esVacia(L1), esVacia(L2).


bienEtiquetado2(nodo(EP, arista(Y,nodo(EH,Z)))) :-
	    integer(EP), integer(Y), integer(EH), Y =:= EP - EH,
        bienEtiquetado2(nodo(EH,Z)).

bienEtiquetado2(nodo(E,[X|XS])) :-
        bienEtiquetado2(nodo(E,X)),!,
        bienEtiquetado2(nodo(E,XS)).

% ------------- Predicado Principal --------------
bienEtiquetado(Arbol) :- bienEtiquetado2(Arbol,[],[]).

% Arboles como Listas


