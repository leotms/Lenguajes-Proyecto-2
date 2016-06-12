% Autores:
% Aldrix Marfil     10-10940.
% Leonardo Martinez 11-10576.

% Arboles como Estructuras
% nodo(Etiqueta,[]) :- integer(Etiqueta).
% nodo(Etiqueta,[X|Y]) :- integer(Etiqueta).
% arista(Etiqueta, Nodo) :- integer(Etiqueta) , nodo(Nodo).

esVacia([]).

noEstaEnLaLista(X,[]) :- integer(X).
noEstaEnLaLista(X,[Y|Z]) :- integer(X), integer(Y), X =\= Y, noEstaEnLaLista(X,Z).

insertarEnLaLista(X,[],[X]).
insertarEnLaLista(X,Y,[X|Y]). % :- noEstaEnLaLista(X,Y).


% ----------------------------- bienEtiquetado --------------------------------
% Predicado que indica si los nodos de un arbol estan bien etiquetados.

bienEtiquetado2(nodo(E,[]),LN,LA,RN,LA) :- integer(E), 
		insertarEnLaLista(E,LN,RN).

bienEtiquetado2(nodo(EP, arista(Y,nodo(EH,Z))),LN,LA,MN,MA) :-
	   integer(EP), integer(Y), integer(EH), Y =:= EP - EH, 
	   insertarEnLaLista(Y,LA,RA),
       bienEtiquetado2(nodo(EH,Z),LN,RA,MN,MA).

bienEtiquetado2(nodo(E,[X|XS]),LN,LA,XN,XA) :-
        bienEtiquetado2(nodo(E,X),LN,LA,RN,RA),!,
        bienEtiquetado2(nodo(E,XS),RN,RA,XN,XA).

% ------------- Predicado Principal --------------
bienEtiquetado2(Arbol,[],[],RN,RA).

% Arboles como Listas


