# language: es

Característica:
Como usuario
quiero que el bot me indique si mi usuario ya existe en el sistema
saber que debo registrarme nuevamente

Escenario: US2.1-01 No puedo registrarme si ya estoy registrado
Dado que mi usuario es "juan" con id "1" y mail "juan@gmail.com", y estoy registrado
Cuando envio el comando "/registrar" con email "juan@gmail.com"
Entonces el bot muestra el mensaje "El usuario juan ya esta registrado"

Escenario: US2.1-02 No puedo registrarme con un correo que ya fue registrado
Dado que mi usuario es "juan", mi id es "1" y no estoy registrado
Y existe un usuario registrado con el mail "juan@gmail.com"
Cuando envio el comando "/registrar" con email "juan@gmail.com"
Entonces el bot muestra el mensaje "Ya existe un usuario con ese mail, intenta registrarte con otro mail"
