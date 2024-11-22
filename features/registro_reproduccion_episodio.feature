# language: es
Característica:
Como sistema
quiero registrar que un usuario escucho un episodio de un podcast
para poder mejorar las recomendaciones futuras basadas en su historial de escucha.

Antecedentes:
Dado que mi usuario es "juan" con id "1235" y mail "juan@gmail.com", y estoy registrado
Y que existe el podcast "Caja Negra" con "2" episodios

Escenario: US13-01 Registro exitoso de reproducción
Cuando el sistema recibe una solicitud de registro con mail "juan@gmail.com" del primer episodio de "Caja Negra"
Entonces el sistema actualiza el historial de escucha del usuario

Escenario: US13-02 Registro de reproducción con usuario no registrado
Cuando el sistema recibe una solicitud de registro con mail "facundo@gmail.com" del primer episodio de "Caja Negra"
Entonces el sistema devuelve un mensaje de error "El usuario no fue encontrado."
Y no actualiza el historial de escucha del usuario

Escenario: US13-03 Registro de reproducción de un podcast inexistente
Cuando el sistema recibe una solicitud de registro con mail "juan@gmail.com" de un podcast inexistente
Entonces el sistema devuelve un mensaje de error "El contenido no fue encontrado."
Y no actualiza el historial de escucha del usuario

Escenario: US13-04 Registro de reproducción de un podcast existente pero de un episodio inexistente
Cuando el sistema recibe una solicitud de registro con mail "juan@gmail.com" de un episodio inexistente
Entonces el sistema devuelve un mensaje de error "El contenido no fue encontrado."
Y no actualiza el historial de escucha del usuario

Escenario: US13-05 Registro de reproducción de un podcast y episodio existentes cuando el episodio no pertenece al podcast
Dado que existe el podcast "Manuelita" con "2" episodios
Cuando el sistema recibe una solicitud de registro con mail "juan@gmail.com" del podcast de "Caja Negra" y id del primer episodio de "Manuelita"
Entonces el sistema devuelve un mensaje de error "El episodio no pertenece al podcast."
Y no actualiza el historial de escucha del usuario
@wip
Escenario: US13-06 Registro reproduccion de un episodio y podcast de igual id a un podcast existente
Cuando el sistema recibe una solicitud de registro con el mail "juan@gmail.com" de id podcast de "Caja Negra" y id episodio de "Caja Negra"
Entonces el sistema devuelve un mensaje de error "El episodio no existe."
@wip
Escenario: US13-07 Registro reproduccion de un episodio y podcast de igual id a un episodio existente
Cuando el sistema recibe una solicitud de registro con el mail "juan@gmail.com" de id podcast del primer episodio "Caja Negra" y id episodio  del primer episodio
Entonces el sistema devuelve un mensaje de error "El podcast no existe."
