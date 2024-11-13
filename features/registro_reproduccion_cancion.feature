# language: es
Característica:
Como sistema
quiero registrar que un usuario escucho una cancion
para poder mejorar las recomendaciones futuras basadas en su historial de escucha.

Antecedentes:
Dado que mi usuario es "juan" con id "1" y mail "juan@gmail.com", y estoy registrado
Y que existe la cancion "Waka Waka"

@wip
Escenario: US6-01 Registro exitoso de reproduccion
Dado que el sistema recibe una solicitud de registro con mail "juan@gmail.com" y el id de la cancion "Waka Waka"
Entonces el sistema actualiza el historial de escucha del usuario

@wip
Escenario: US6-02 Registro de reproduccion con usuario no registrado
Dado que el sistema recibe una solicitud de registro con mail "facundo@gmail.com" e id de cancion "1234"
Entonces el sistema devuelve un mensaje de error "Usuario no encontrado"
Y no actualiza el historial de escucha del usuario

@wip
Escenario: US6-03 Registro de reproduccion de una cancion inexistente
Dado que el sistema recibe una solicitud de registro con mail "juan@gmail.com" e id de cancion "5687"
Entonces el sistema devuelve un mensaje de error "Cancion no encontrada"
Y no actualiza el historial de escucha del usuario
