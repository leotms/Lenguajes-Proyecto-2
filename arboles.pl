% Autores:
% Aldrix Marfil     10-10940.
% Leonardo Martinez 11-10576.

% Arboles como Estructuras
% nodo(Etiqueta,[]) :- integer(Etiqueta).
% nodo(Etiqueta,[X|Y]) :- integer(Etiqueta).
% arista(Etiqueta, Nodo) :- integer(Etiqueta) , nodo(Nodo).

% Predicado que indica si los nodos de un arbol estan bien etiquetados.

esVacia([]).

% ---------------- Casos Base --------------------
bienEtiquetado(nodo(E,X))      :- integer(E), esVacia(X).


bienEtiquetado(nodo(EP,[arista(Y,nodo(EH,Z))])) :-
        integer(EP) ,
        integer(Y),
        integer(EH),
        esVacia(Z),
        Y =:= EP - EH.

% ------------------------------------------------

bienEtiquetado(nodo(EP,[arista(Y,nodo(EH,Z))])) :-
        integer(EP) ,
        integer(Y),
        integer(EH),
        Y =:= EP - EH,
        bienEtiquetado(nodo(EH,Z)).

bienEtiquetado(nodo(E,[X|XS])) :-
        bienEtiquetado(nodo(E,X)),
        bienEtiquetado(nodo(E,XS)).

% ------------- Funcion Principal -------------- 
bienEtiquetado(+Arbol) :- bienEtiquetado(Arbol).



%Arboles como Listas
% li(X)        :- list(X).
% li([X])      :- integer(X).
% esq([X|Y]) :- li(X), esq(Y).
%
% listaEntero(X) :-   list(X).
% listaEntero([X]) :- integer(X).
% listaEntero([X|Y]) :- integer(X), listaEntero(Y).
