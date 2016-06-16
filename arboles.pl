%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autores:																	  %
% Aldrix Marfil     10-10940.												  %
% Leonardo Martinez 11-10576.												  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% ------------------------ Auxiliares bienEtiquetado --------------------------

% Permite saber el cual es el maximo entre dos numeros.
maximo(X,Y,R) :- X>Y, R is X,!.
maximo(_X,Y,Y).

% Permite saber cual es el maximo valor de los elementos de una lista.
maximoDeLaLista(I,[X],R) :- maximo(I,X,R).
maximoDeLaLista(I,[X|Y],R) :- maximo(I,X,AuxR), maximoDeLaLista(AuxR,Y,R).

% Permite saber si un elemento no es miembro de una lista.
noEstaEnLaLista(X,[]) :- integer(X).
noEstaEnLaLista(X,[Y|Z]) :- integer(X), integer(Y), X =\= Y,
							noEstaEnLaLista(X,Z).

% Inserta un elemento X al inicio de la lista pasada como segundo argumento.
insertarEnLaLista(X,[],[X]).
insertarEnLaLista(X,Y,[X|Y]) :- noEstaEnLaLista(X,Y).


% ----------------------------- bienEtiquetado --------------------------------
% =============================================================================
% Predicado que indica si los nodos de un arbol estan bien etiquetados.
% Parametros: Arbol - Estructura de arbol representada como
%					  nodo(EN1,[arista(EA,nodo(EN2,[])))

bienEtiquetadoAux(nodo(E,[]),LN,LA,RN,LA) :-
		integer(E), E > 0,
		insertarEnLaLista(E,LN,RN).

bienEtiquetadoAux(nodo(EP,arista(Y,nodo(EH,Z))),LN,LA,RN,RA) :-
	    integer(EP), integer(Y), integer(EH),
	    Y =:= abs(EP - EH), Y > 0,
	    insertarEnLaLista(Y,LA,AuxA),
        bienEtiquetadoAux(nodo(EH,Z),LN,AuxA,RN,RA).

bienEtiquetadoAux(nodo(E,[X|XS]),LN,LA,RN,RA) :-
        bienEtiquetadoAux(nodo(E,X),LN,LA,AuxN,AuxA), !,
        bienEtiquetadoAux(nodo(E,XS),AuxN,AuxA,RN,RA).

% -------- Predicado Principal --------
bienEtiquetado(Arbol) :-
		bienEtiquetadoAux(Arbol,[],[],RN,RA), !, length(RN,X),
		maximoDeLaLista(0,RN,MaxN), MaxN =< X,
		maximoDeLaLista(0,RA,MaxA), MaxA =< X - 1, !.


% ------------------------ Auxiliares esqueleto -------------------------------

% Permite generar listas con todas las combinaciones entre 0 un maximo.
generarLista(0,_,L,L).

generarLista(TAM,MAX,L,LR) :- TAM>0, between(0,MAX,X), append(L,[X],AuxL),
 							  R is TAM-1, generarLista(R,MAX,AuxL,LR).

lista(TAM,MAX,L) :- generarLista(TAM,MAX,[],L).


% Permite verificar que una lista es no creciente.
verificarListaNoCreciente(L) :- length(L,T), T < 2.

verificarListaNoCreciente([X0,X1|XS]) :- X0 >= X1,
                                         verificarListaNoCreciente([X1|XS]).


% ------------------------------- esqueleto -----------------------------------
% =============================================================================
% Permite calcular representaciones de arboles, no ordenados, como listas.
% Parametros: N         - Numero de nodos que posee el arbol.
%             R         - Cantidad maxima de hijos que puede tener un nodo.
%             Esqueleto - Arbol representado como lista para una configuracion
%                         especifica.

esqueletoAux(1,_,L,ESQ,TamL) :-
		lista(TamL,0,AuxL), append(L,[AuxL],ESQ).

esqueletoAux(N,R,L,ESQ,TamL) :-
		N > 1, lista(TamL,R,AuxL1),
		verificarListaNoCreciente(AuxL1),
		sum_list(AuxL1,AuxSumL),   % Sumamos para saber el tamano de la lista de los hijos.
		AuxSumL > 0,
		append(L,[AuxL1],AuxL2),
		AuxN is N-AuxSumL,         % Disminuimos el numero de nodos.
		esqueletoAux(AuxN,R,AuxL2,ESQ,AuxSumL).

% -------- Predicado Principal --------
esqueleto(1,_,[[0]]).
esqueleto(N,R,ESQ) :- N > 1, esqueletoAux(N,R,[],ESQ,1).


% ---------------------- Auxiliares etiquetamiento ----------------------------

% Permite obtener la cabeza de una lista.
obtenerCabeza([X|_XS],X).

% Permite insertar al inicio de una lista.
insertarAlPrincipioLista(X,[],[X]).
insertarAlPrincipioLista(X,[Y|YS],[X,Y|YS]).

% Permite concatenar dos listas.
concatenarListas(X,[],X).
concatenarListas([],X,X).
concatenarListas([X|XS],L,[X|Z]) :- concatenarListas(XS,L,Z),!.

% Permite concatener el primer elemento de dos listas en un solo elemento.
concatenarCabezas([],[],[]).
concatenarCabezas(L,[],L).
concatenarCabezas([],L,L).
concatenarCabezas([X|XS],[Y|YS],[C|Z]) :- concatenarListas(X,Y,C),
										  concatenarCabezas(XS,YS,Z).
% Permite decir si dos listas son iguales.
compararListas([],[]).
compararListas([X|XS],[Y|YS]) :- length(XS,T1), length(YS,T2),
								 T1=:=T2, X=:=Y, compararListas(XS,YS).

% Permite comparar si dos esqueletos son iguales.
compararEsqueletos([],[]).
compararEsqueletos([XS|XSS],[YS|YSS]) :- length(XSS,T1), length(YSS,T2),
									     T1=:=T2, compararListas(XS,YS),
									     compararEsqueletos(XSS,YSS).


% --------------------------- etiquetamiento ----------------------------------
% =============================================================================
% Permite saber si Arbol es un buen etiquetamiento de Esqueleto.
% Parametros: Esqueleto - Arbol representado como lista para una configuracion
%                         especifica.
%             Arbol     - Arbol - Estructura de arbol representada como
%					      nodo(EN1,[arista(EA,nodo(EN2,[])))

etiquetamientoAuxAristas([],[]).

etiquetamientoAuxAristas([arista(_EA,nodo(EN,Z))|AS],Esq) :-
		etiquetamientoAux(nodo(EN,Z),AuxEsq1),
		etiquetamientoAuxAristas(AS,AuxEsq2),
		concatenarCabezas(AuxEsq1,AuxEsq2,Esq),!.

etiquetamientoAux(nodo(_E,[]),[[0]]).

etiquetamientoAux(nodo(_EN1,arista(_EA,nodo(EN2,Z))),Esq) :-
		etiquetamientoAux(nodo(EN2,Z),Esq).

etiquetamientoAux(nodo(_E,A),Esq) :-
		etiquetamientoAuxAristas(A,AuxEsq),
		length(A,T), insertarAlPrincipioLista([T],AuxEsq,Esq).

etiquetamiento(Esqueleto,Arbol) :- etiquetamientoAux(Arbol,Esq),!,
								   compararEsqueletos(Esqueleto,Esq).


% ---------------------------- esqtiquetable ----------------------------------
% =============================================================================
% Permite saber si todos los esqueletos de arboles R-arios con N nodos son bien
% etiquetables.
% Parametros: Arbol -


% ------------------------ describirEtiquetamiento ----------------------------
% =============================================================================
% Permite mostrar en pantalla la descripcion de un Arbol y su etiquetamiento.
% Parametros: Arbol - Estructura de arbol representada como
%					  nodo(EN1,[arista(EA,nodo(EN2,[])))

describirEtiquetamientoAux(nodo(E,[]),NpID, _NherID) :-
			escribirNodo(NpID,E), write('\n').

describirEtiquetamientoAux(nodo(_EP,arista(Y,nodo(EH,Z))), NpID, NherID) :-
			concatenarIdentificador(NpID,NherID,NewID),
			escribirArista(Y),
			describirEtiquetamientoAux(nodo(EH,Z),NewID,0).

describirEtiquetamientoAux(nodo(E,[X|XS]),NpID, NherID) :-
			escribirNodo(NpID,E),!,
			describirEtiquetamientoAux(nodo(E,X),NpID,NherID),
			Naux is NherID + 1,
			describirEtiquetamientoAux(nodo(E,XS),NpID, Naux),!.

% -------- Predicado Principal --------
describirEtiquetamiento(Arbol) :- describirEtiquetamientoAux(Arbol,'0',0).

escribirNodo(Nid,E) :- write(Nid), write(' ('), write(E), write(') ').

escribirArista(E)   :- write(' -- '), write(E), write(' -- ').

concatenarIdentificador(ID1, ID2, X) :-
			atom_concat(ID1,'.',X2),
			atom_concat(X2,ID2,X).
