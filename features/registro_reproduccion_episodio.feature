# language: es
Característica:
Como sistema
quiero registrar que un usuario escucho un episodio de un podcast
para poder mejorar las recomendaciones futuras basadas en su historial de escucha.

Antecedentes:
Dado que mi usuario es "juan" con id "1235" y mail "juan@gmail.com", y estoy registrado
Y que existe el podcast "Caja Negra" con "2" episodios
@wip
Escenario: US13-01 Registro exitoso de reproducción
Cuando el sistema recibe una solicitud de registro con mail "juan@gmail.com" del primer episodio de "Caja Negra"
Entonces el sistema actualiza el historial de escucha del usuario
@wip
Escenario: US13-02 Registro de reproducción con usuario no registrado
Cuando el sistema recibe una solicitud de registro con mail "facundo@gmail.com" del primer episodio de "Caja Negra"
Entonces el sistema devuelve un mensaje de error "Usuario no encontrado"
Y no actualiza el historial de escucha del usuario
@wip
Escenario: US13-03 Registro de reproducción de un podcast inexistente
Cuando el sistema recibe una solicitud de registro con mail "juan@gmail.com" de un podcast inexistente
Entonces el sistema devuelve un mensaje de error "Podcast no encontrado"
Y no actualiza el historial de escucha del usuario
@wip
Escenario: US13-04 Registro de reproducción de un podcast existente pero de un episodio inexistente
Cuando el sistema recibe una solicitud de registro con mail "juan@gmail.com" de un episodio inexistente de "Caja Negra"
Entonces el sistema devuelve un mensaje de error "Episodio no encontrado"
Y no actualiza el historial de escucha del usuario
@wip
Escenario: US13-05 Registro de reproducción de un podcast y episodio existentes cuando el episodio no pertenece al podcast
Dado que existe el podcast "Manuelita" con "2" episodios
Cuando el sistema recibe una solicitud de registro con mail "juan@gmail.com" del podcast de "Caja Negra" y id del primer episodio de "Manuelita"
Entonces el sistema devuelve un mensaje de error "Episodio no pertenece al podcast"
Y no actualiza el historial de escucha del usuario
