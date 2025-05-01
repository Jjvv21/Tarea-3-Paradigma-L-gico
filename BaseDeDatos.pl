% ----------------------------
% HECHOS: AEROPUERTOS (NODOS)
% ----------------------------
% ato(Código, Ciudad, País)
ato('SJO', 'San José', 'Costa Rica').
ato('PTY', 'Ciudad de Panamá', 'Panamá').
ato('PHX', 'Phoenix', 'Estados Unidos').
ato('LAX', 'Los Ángeles', 'Estados Unidos').
ato('MIA', 'Miami', 'Estados Unidos').

% ----------------------------
% HECHOS: VUELOS (ARCOS)
% ----------------------------
% Formato: arco(Aerolínea, NúmeroVuelo, Origen, Destino, Tiempo, Clase, Costo)

% Vuelos de COPA Airlines
arco('COPA Airlines', 'CM404', 'SJO', 'PTY', 1, ambas, 300).
arco('COPA Airlines', 'CM405', 'PTY', 'SJO', 1, economica, 280).
arco('COPA Airlines', 'CM888', 'PTY', 'MIA', 3, negocios, 600).

% Vuelos de United Airlines
arco('United Airlines', 'UA105', 'PTY', 'PHX', 6, economica, 400).
arco('United Airlines', 'UA777', 'LAX', 'PHX', 1, negocios, 200).
arco('United Airlines', 'UA789', 'SJO', 'PHX', 8, negocios, 1200).

% Vuelos de American Airlines
arco('American Airlines', 'AA202', 'SJO', 'MIA', 2.5, economica, 250).
arco('American Airlines', 'AA123', 'MIA', 'LAX', 5, negocios, 800).

% Vuelos de Delta Airlines
arco('Delta Airlines', 'DL333', 'MIA', 'PHX', 4, negocios, 700).
arco('Delta Airlines', 'DL456', 'PTY', 'LAX', 6, economica, 450).

% Vuelos de LATAM
arco('LATAM Airlines', 'LA501', 'SJO', 'LAX', 5, economica, 600).

% ----------------------------
% REGLAS DE BÚSQUEDA
% ----------------------------

% Predicado principal para encontrar rutas
path(Origen, Destino, Aerolinea, Clase, Presupuesto, Costo, Tiempo, Rutas) :-
    path(Origen, Destino, Aerolinea, Clase, Presupuesto, Costo, Tiempo, [], Rutas).

% Caso base: vuelo directo
path(Origen, Destino, Aerolinea, Clase, Presupuesto, Costo, Tiempo, _,
     [[Aerolinea, Vuelo, Origen, Destino, Tiempo, Clase, Costo]]) :-
    arco(Aerolinea, Vuelo, Origen, Destino, Tiempo, Clase, Costo),
    Presupuesto >= Costo.

% Caso recursivo: vuelos con escalas
path(Origen, Destino, Aerolinea, Clase, Presupuesto, Costo, Tiempo, Visitados,
     [[Aerolinea, Vuelo, Origen, Escala, T1, Clase, C1]|Ruta]) :-
    arco(Aerolinea, Vuelo, Origen, Escala, T1, Clase, C1),
    \+ member(Escala, Visitados),
    C1 =< Presupuesto,
    path(Escala, Destino, Aerolinea, Clase, Presupuesto - C1, C2, T2, [Origen|Visitados], Ruta),
    Costo is C1 + C2,
    Tiempo is T1 + T2.

% ----------------------------
% REGLAS DE FILTRADO
% ----------------------------

% Encontrar el vuelo más barato
camino_mas_barato(Origen, Destino, Aerolinea, Clase, Presupuesto, Costo, Ruta) :-
    findall(C-R, (
        path(Origen, Destino, Aerolinea, Clase, Presupuesto, C, _, R),
        R \= []
    ), Rutas),
    sort(Rutas, [Costo-Ruta|_]).

% Encontrar el vuelo más rápido
camino_mas_rapido(Origen, Destino, Aerolinea, Clase, Presupuesto, Tiempo, Ruta) :-
    findall(T-R, (
        path(Origen, Destino, Aerolinea, Clase, Presupuesto, _, T, R),
        R \= []
    ), Rutas),
    sort(Rutas, [Tiempo-Ruta|_]).

% ----------------------------
% PREDICADOS AUXILIARES
% ----------------------------

es_origen(Aeropuerto) :- ato(Aeropuerto, _, _).
es_destino(Origen, Destino) :- ato(Destino, _, _), Origen \= Destino.
es_aerolinea(Aerolinea) :- arco(Aerolinea, _, _, _, _, _, _).
es_clase(Clase) :- member(Clase, [economica, negocios, ambas]).

% Validación de presupuesto
fuera_de_presupuesto(Presupuesto, Costo) :-
    Costo > Presupuesto,
    write('Presupuesto insuficiente. Se requiere $'),
    write(Costo), write(' pero su presupuesto es $'),
    write(Presupuesto), nl.
