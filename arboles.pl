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

% Permite saber el cual es el maximo entre dos numeros.
maximo(X,Y,R) :- X>Y, R is X,!.
maximo(_X,Y,Y).

% Permite saber cual es el maximo valor de los elementos de una lista.
maximoDeLaLista(I,[X],R) :- maximo(I,X,R).
maximoDeLaLista(I,[X|Y],R) :- maximo(I,X,AuxR), maximoDeLaLista(AuxR,Y,R).

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
		integer(E), E > 0,
		insertarEnLaLista(E,LN,RN).

bienEtiquetado2(nodo(EP,arista(Y,nodo(EH,Z))),LN,LA,RN,RA) :-
	    integer(EP), integer(Y), integer(EH),
	    Y =:= abs(EP - EH), Y > 0,
	    insertarEnLaLista(Y,LA,AuxA),
        bienEtiquetado2(nodo(EH,Z),LN,AuxA,RN,RA).

bienEtiquetado2(nodo(E,[X|XS]),LN,LA,RN,RA) :-
        bienEtiquetado2(nodo(E,X),LN,LA,AuxN,AuxA), !,
        bienEtiquetado2(nodo(E,XS),AuxN,AuxA,RN,RA).

% -------- Predicado Principal --------
bienEtiquetado(Arbol) :-
		bienEtiquetado2(Arbol,[],[],RN,RA), !, length(RN,X), 
		maximoDeLaLista(0,RN,MaxN), MaxN =< X, 
		maximoDeLaLista(0,RA,MaxA), MaxA =< X - 1, !.

% Arboles como listas

agregarEsqueleto(X,V, Esq) :- insertarEnLaLista(V,X,EsqAux), Esq is EsqAux.
esqueleto(1,1,Esq) :- agregarEsqueleto([],1,EsqAux), Esq is EsqAux.
