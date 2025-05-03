:-consult(bnf).
:-consult(basededatos).


preguntar_oracion(FraseValida) :-
    write('Por favor, ingrese los datos de su viaje, como el origen, el destino, la aerolinea en la que desea viajar, la clase en la que desea viajar y su presupuesto:\n'),
    readln(Frase, _, _, _, lowercase),
    ( oraciones_restantes(Frase,[]) ->
        write('Frase v�lida.\n'),
        FraseValida = Frase
    ;
        write('Frase no v�lida, int�ntelo de nuevo.\n'),
        preguntar_oracion(FraseValida)
    ).

iniciar():-
	write('Bienvenido a TravelAgencyLog, la mejor logica de llegar a su destino. \n'),
	preguntar_oracion(_).
