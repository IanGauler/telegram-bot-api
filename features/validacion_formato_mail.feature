# language: es
Característica:
  Como usuario
  quiero que el bot verifique mis datos de registro
  para saber si me pude registrar exitosamente o hubo algun error.

Antecedentes:
  Dado que mi usuario es "juan", mi id es "1" y no estoy registrado

Escenario: US2.2-01 No puedo registrarme con un correo sin caracteres luego de la @
  Cuando envio el comando "/registrar" con email "juan@"
  Entonces el bot muestra el mensaje "Por favor, ingresa un correo valido."

Escenario: US2.2-02 No puedo registrarme con un correo que no incluye una @
  Cuando envio el comando "/registrar" con email "juangmail.com"
  Entonces el bot muestra el mensaje "Por favor, ingresa un correo valido."

Escenario: US2.2-03 No puedo registrarme con un correo que no incluye caracteres antes de la @
  Cuando envio el comando "/registrar" con email "@gmail.com"
  Entonces el bot muestra el mensaje "Por favor, ingresa un correo valido."

Escenario: US2.2-04 No puedo registrarme con un correo que no incluye caracteres despues de la @ y antes del punto
  Cuando envio el comando "/registrar" con email "juan@.com"
  Entonces el bot muestra el mensaje "Por favor, ingresa un correo valido."

Escenario: US2.2-05 No puedo registrarme con un correo que no incluye caracteres despues del punto
  Cuando envio el comando "/registrar" con email "@juan@gmail."
  Entonces el bot muestra el mensaje "Por favor, ingresa un correo valido."
