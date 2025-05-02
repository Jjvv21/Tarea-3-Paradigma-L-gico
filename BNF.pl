:- consult('BaseDeDatos.pl').

% ----------------------------
% CATEGOR�AS L�XICAS AMPLIADAS
% ----------------------------

% Verbos de acci�n (conjugaciones y sin�nimos)
verbo_accion -->
    [estoy]; [estar]; [encuentro]; [encontrar]; [quiero]; [querer];
    [deseo]; [desear]; [necesito]; [necesitar]; [busco]; [buscar];
    [prefiero]; [preferir]; [gustaria]; [planeo]; [planear];
    [viajo]; [viajar]; [reservo]; [reservar]; [compro]; [comprar].

% T�rminos relacionados con vuelos (sin�nimos y variantes)
termino_vuelo -->
    [vuelo]; [vuelos]; [avion]; [aviones]; [pasaje]; [pasajes];
    [boleto]; [boletos]; [ticket]; [tickets]; [reserva]; [reservas];
    [itinerario]; [viaje]; [traslado]; [conexion]; [escala].

% Clases de vuelo (con variantes)
clase_gram -->
    [economica]; [turista]; [basica]; [standard];
    [ejecutiva]; [negocios]; [business]; [premium];
    [primera]; [first]; [clase]; [ambas].

% Preposiciones y conectores
conector -->
    [a]; [al]; [de]; [del]; [desde]; [hacia]; [hasta]; [en]; [por];
    [con]; [sin]; [para]; [mi]; [mis]; [un]; [una]; [unos]; [unas];
    [el]; [la]; [los]; [las]; [su]; [sus]; [este]; [esta].

% Adverbios y modificadores
modificador -->
    [si]; [no]; [tambien]; [ademas]; [solo]; [solamente]; [quizas];
    [talvez]; [posiblemente]; [normalmente]; [generalmente];
    [rapido]; [barato]; [economico]; [comodo]; [directo].

% ----------------------------
% SINTAXIS FLEXIBLE
% ----------------------------

% Patrones para origen
expresion_origen -->
    ([estoy, en, Lugar] |
     [salgo, de, Lugar] |
     [origen, es, Lugar] |
     [parto, desde, Lugar] |
     [vengo, de, Lugar] |
     [mi, salida, es, Lugar]),
    {validar_lugar(Lugar)}.

% Patrones para destino
expresion_destino -->
    ([voy, a, Lugar] |
     [destino, es, Lugar] |
     [quiero, ir, a, Lugar] |
     [viajo, hacia, Lugar] |
     [direccion, Lugar] |
     [llegar, a, Lugar]),
    {validar_lugar(Lugar)}.

% Patrones para preferencias
expresion_preferencia -->
    expresion_aerolinea | expresion_clase | expresion_presupuesto |
    expresion_tiempo | expresion_escalas.

expresion_aerolinea -->
    ([prefiero, Aerolinea] |
     [aerolinea, Aerolinea] |
     [con, Aerolinea] |
     [usando, Aerolinea] |
     [por, Aerolinea] |
     [que, vuele, con, Aerolinea]),
    {es_aerolinea(Aerolinea)}.

expresion_clase -->
    ([clase, Clase] |
     [en, clase, Clase] |
     [quiero, Clase] |
     [categoria, Clase] |
     [servicio, Clase]),
    {member(Clase, [economica, negocios, ambas])}.

% ----------------------------
% GRAM�TICA PRINCIPAL
% ----------------------------

oracion_completa -->
    (saludo | []),
    expresion_origen,
    expresion_destino,
    (expresion_preferencia | []),
    (cierre | []).

saludo --> [hola] | [buenos, dias] | [buenas, tardes] | [saludos].

cierre --> [gracias] | [por, favor] | [eso, es, todo] | [adi�s].

% ----------------------------
% REGLAS DE VALIDACI�N
% ----------------------------

validar_lugar(Lugar) :-
    (ato(Lugar, _, _) ;
     arco(_, _, Lugar, _, _, _, _) ;
     arco(_, _, _, Lugar, _, _, _) ;
     (sin�nimo_lugar(Lugar, LugarReal), ato(LugarReal, _, _))),
    !.

sin�nimo_lugar('sanjose', 'SJO').
sin�nimo_lugar('san jose', 'SJO').
sin�nimo_lugar('panama', 'PTY').
sin�nimo_lugar('ciudad de panama', 'PTY').

% ----------------------------
% EXTRACCI�N DE DATOS MEJORADA
% ----------------------------

extraer_datos :-
    findall(Origen, retract(origen_actual(Origen)), Origenes),
    findall(Destino, retract(destino_actual(Destino)), Destinos),
    findall(Aerolinea, retract(aerolinea_preferida(Aerolinea)), Aerolineas),
    findall(Clase, retract(clase_preferida(Clase)), Clases),
    findall(Presupuesto, retract(presupuesto_maximo(Presupuesto)), Presupuestos),
    (Origenes = [] -> fail ; Origenes = [Origen|_]),
    (Destinos = [] -> fail ; Destinos = [Destino|_]),
    (Aerolineas = [] -> Aerolinea = _ ; Aerolineas = [Aerolinea|_]),
    (Clases = [] -> Clase = ambas ; Clases = [Clase|_]),
    (Presupuestos = [] -> Presupuesto = inf ; Presupuestos = [Presupuesto|_]),
    procesar_consulta(Origen, Destino, Aerolinea, Clase, Presupuesto).

procesar_consulta([Origen|_], [Destino|_], Aerolineas, Clases, Presupuestos) :-
    (Aerolineas = [] -> Aerolinea = _ ; Aerolineas = [Aerolinea|_]),
    (Clases = [] -> Clase = ambas ; Clases = [Clase|_]),
    (Presupuestos = [] -> Presupuesto = inf ; Presupuestos = [Presupuesto|_]),
    buscar_vuelos(Origen, Destino, Aerolinea, Clase, Presupuesto).







