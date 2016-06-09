% Autores:
% Aldrix Marfil     10-10940.
% Leonardo Martinez 11-10576.

% Arboles como Estructuras
nodo(Etiqueta,[]) :- integer(Etiqueta).
nodo(Etiqueta,[X|Y]) :- integer(Etiqueta).


%Arboles como Lista
li(X)        :- list(X).
li([X])      :- integer(X).
esq([X|Y]) :- li(X), esq(Y).

listaEntero(X) :-   list(X).
listaEntero([X]) :- integer(X).
listaEntero([X|Y]) :- integer(X), listaEntero(Y).
