# language: es
Característica:
Como sistema
quiero registrar que un usuario escucho un episodio de un podcast
para poder mejorar las recomendaciones futuras basadas en su historial de escucha.

Antecedentes:
Dado que mi usuario es "juan" con id "1235" y mail "juan@gmail.com", y estoy registrado
Y que existe el podcast "Caja Negra" con id "10"
Y que existe el episodio "101" de "Caja Negra"
Y que existe el episodio "102" de "Caja Negra"

@wip
Escenario: US13-01 Registro exitoso de reproducción
Cuando el sistema recibe una solicitud de registro con mail "juan@gmail.com" del episodio "101" con id "10" del podcast "Caja Negra"
Entonces el sistema actualiza el historial de escucha del usuario

@wip
Escenario: US13-02 Registro de reproducción con usuario no registrado
Cuando que el sistema recibe una solicitud de registro con mail "facundo@gmail.com" del episodio "101" con id "10" del podcast "Caja Negra"
Entonces el sistema devuelve un mensaje de error "Usuario no encontrado"
Y no actualiza el historial de escucha del usuario
@wip
Escenario: US13-03 Registro de reproducción de un podcast inexistente
Cuando que el sistema recibe una solicitud de registro con mail "juan@gmail.com" del episodio "101" de un podcast inexistente
Entonces el sistema devuelve un mensaje de error "Podcast no encontrado"
Y no actualiza el historial de escucha del usuario
@wip
Escenario: US13-04 Registro de reproducción de un podcast existente pero de un episodio inexistente
Cuando el sistema recibe una solicitud de registro con mail "juan@gmail.com" del episodio "105 "con id "10" del podcast "Caja Negra"
Entonces el sistema devuelve un mensaje de error "Episodio no encontrado"
Y no actualiza el historial de escucha del usuario
@wip
Escenario: US13-05 Registro de reproducción de un podcast y episodio existentes cuando el episodio no pertenece al podcast
Dado que existe el podcast "Manuelita" con id "20"
Y que existe el episodio "201" de "Manuelita"
Cuando el sistema recibe una solicitud de registro con mail "juan@gmail.com" del episodio "101" con id "20" del podcast "Manuelita"
Entonces el sistema devuelve un mensaje de error "Episodio no pertenece al podcast"
Y no actualiza el historial de escucha del usuario
