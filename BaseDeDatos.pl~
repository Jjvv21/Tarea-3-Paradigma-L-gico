% ----------------------------
% HECHOS: AEROPUERTOS (NODOS)
% ----------------------------
% ato(Código, Ciudad, País)
ato('sjo', 'san_jose', 'costa_rica').
ato('pty', 'ciudad_de_panama', 'panama').
ato('phx', 'phoenix', 'estados_unidos').
ato('lax', 'los_angeles', 'estados_unidos').
ato('mia', 'miami', 'estados_unidos').

% ----------------------------
% HECHOS: VUELOS (ARCOS)
% ----------------------------
% Formato: arco(Aerolínea, NúmeroVuelo, Origen, Destino, Tiempo, Clase, Costo)

% Vuelos de COPA Airlines
arco('copa_airlines', 'CM404', 'sjo', 'pty', 1, ambas, 300).
arco('copa_airlines', 'CM405', 'pty', 'sjo', 1, economica, 280).
arco('copa_airlines', 'CM888', 'pty', 'mia', 3, negocios, 600).

% Vuelos de United Airlines
arco('united_airlines', 'UA105', 'pty', 'phx', 6, economica, 400).
arco('united_airlines', 'UA777', 'lax', 'phx', 1, negocios, 200).
arco('united_airlines', 'UA789', 'sjo', 'phx', 8, negocios, 1200).

% Vuelos de American Airlines
arco('american_airlines', 'AA202', 'sjo', 'mia', 2.5, economica, 250).
arco('american_airlines', 'AA123', 'mia', 'lax', 5, negocios, 800).

% Vuelos de Delta Airlines
arco('delta_airlines', 'DL333', 'mia', 'phx', 4, negocios, 700).
arco('delta_airlines', 'DL456', 'pty', 'lax', 6, economica, 450).

% Vuelos de LATAM
arco('latam_airlines', 'LA501', 'sjo', 'lax', 5, economica, 600).

clase_compatible(ambas, _).
clase_compatible(_, ambas).
clase_compatible(X, X).

% ----------------------------
% REGLAS DE BÚSQUEDA
% ----------------------------

% Predicado principal para encontrar rutas
path(Origen, Destino, Aerolinea, Clase, Presupuesto, Costo, Tiempo, Rutas) :-
    path(Origen, Destino, Aerolinea, Clase, Presupuesto, Costo, Tiempo, [], Rutas).

% Caso base: vuelo directo
path(Origen, Destino, Aerolinea, ClaseDeseada, Presupuesto, Costo, Tiempo, _,
     [[Aerolinea, Vuelo, Origen, Destino, Tiempo, ClaseVuelo, Costo]]) :-
    arco(Aerolinea, Vuelo, Origen, Destino, Tiempo, ClaseVuelo, Costo),
    clase_compatible(ClaseDeseada, ClaseVuelo),
    Presupuesto >= Costo.

% Caso recursivo: vuelos con escalas
path(Origen, Destino, Aerolinea, ClaseDeseada, Presupuesto, Costo, Tiempo, Visitados,
     [[Aerolinea, Vuelo, Origen, Escala, T1, ClaseVuelo, C1]|Ruta]) :-
    arco(Aerolinea, Vuelo, Origen, Escala, T1, ClaseVuelo, C1),
    clase_compatible(ClaseDeseada, ClaseVuelo),
    \+ member(Escala, Visitados),
    C1 =< Presupuesto,
    path(Escala, Destino, Aerolinea, ClaseDeseada, Presupuesto - C1, C2, T2, [Origen|Visitados], Ruta),
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

es_lugar(Aeropuerto) :- ato(Aeropuerto, _, _);ato(_, Aeropuerto, _);ato(_, _, Aeropuerto).
es_lugar(Aeropuerto,Destino):-  ato(Aeropuerto, _, _);ato(_, Aeropuerto, _);ato(_, _, Aeropuerto), Aeropuerto \= Destino.
es_aerolinea(Aerolinea) :- arco(Aerolinea, _, _, _, _, _, _).
es_clase(Clase) :- member(Clase, [economica, negocios, ambas]).

% Validación de presupuesto
fuera_de_presupuesto(Presupuesto, Costo) :-
    Costo > Presupuesto,
    write('Presupuesto insuficiente. Se requiere $'),
    write(Costo), write(' pero su presupuesto es $'),
    write(Presupuesto), nl.
