% -----------------------------------------------------------------------------
% Autores:
% Aldrix Marfil     10-10940.
% Leonardo Martinez 11-10576.
% -----------------------------------------------------------------------------


% Arboles como Estructuras
% nodo(Etiqueta,[]) :- integer(Etiqueta).
% nodo(Etiqueta,[X|Y]) :- integer(Etiqueta).
% arista(Etiqueta, Nodo) :- integer(Etiqueta) , nodo(Nodo).


% ------------------------- Predicados Auxiliares -----------------------------

% Permite saber si un elemento no es miembro de una lista.
noEstaEnLaLista(X,[]) :- integer(X).
noEstaEnLaLista(X,[Y|Z]) :- integer(X), integer(Y), X =\= Y, noEstaEnLaLista(X,Z).

% Inserta un elemento X al inicio de la lista pasada como segundo argumento.
insertarEnLaLista(X,[],[X]).
insertarEnLaLista(X,Y,[X|Y]) :- noEstaEnLaLista(X,Y).


% ----------------------------- bienEtiquetado --------------------------------
% Predicado que indica si los nodos de un arbol estan bien etiquetados.
% Tanto las etiquetas de las aristas como las de los nodos deben ser distintas.

bienEtiquetado2(nodo(E,[]),LN,LA,RN,LA) :-
		integer(E),
		insertarEnLaLista(E,LN,RN).

bienEtiquetado2(nodo(EP, arista(Y,nodo(EH,Z))),LN,LA,RN,RA) :-
	    integer(EP), integer(Y), integer(EH),
	    Y =:= EP - EH,
	    insertarEnLaLista(Y,LA,AuxA),
        bienEtiquetado2(nodo(EH,Z),LN,AuxA,RN,RA).

bienEtiquetado2(nodo(E,[X|XS]),LN,LA,RN,RA) :-
        bienEtiquetado2(nodo(E,X),LN,LA,AuxN,AuxA),!,
        bienEtiquetado2(nodo(E,XS),AuxN,AuxA,RN,RA).

% -------- Predicado Principal --------
bienEtiquetado(Arbol) :- bienEtiquetado2(Arbol,[],[],_RN,_RA),!.
