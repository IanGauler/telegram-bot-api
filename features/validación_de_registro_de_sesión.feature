# language: es
Característica: 
  Como usuario 
  quiero que el bot verifique mis datos de registro 
  para saber si me pude registrar exitosamente o hubo algun error.

  Escenario: US2-01 No puedo registrarme si ya estoy registrado
    Dado que mi mail es "juan@gmail.com", mi id es "1" y estoy registrado
    Cuando envio el comando "/registrar" con email "juan@gmail.com"
    Entonces el bot muestra el error "El usuario juan@gmail.com ya esta registrado"

  @wip
  Escenario: US2-02 No puedo registrarme con un correo sin caracteres luego de la @
    Dado que mi usuario es "juan", mi id es "1" y no estoy registrado
    Cuando envio el comando "/registrar juan@"
    Entonces el bot muestra el mensaje "Por favor, ingresa un correo valido."

  @wip
  Escenario: US2-03 No puedo registrarme con un correo que no incluye una @
    Dado que mi usuario es "juan", mi id es "1" y no estoy registrado
    Cuando envio el comando "/registrar juangmail.com"
    Entonces el bot muestra el mensaje "Por favor, ingresa un correo valido."

  @wip
  Escenario: US2-04 No puedo registrarme con un correo que no incluye caracteres antes de la @
    Dado que mi usuario es "juan" y no estoy registrado
    Cuando envio el comando "/registrar @gmail.com"
    Entonces el bot muestra el mensaje "Por favor, ingresa un correo valido."

  @wip
  Escenario: US2-05 No puedo registrarme con un correo que no incluye caracteres despues de la @ y antes del punto
    Dado que mi usuario es "juan" y no estoy registrado
    Cuando envio el comando "/registrar juan@.com"
    Entonces el bot muestra el mensaje "Por favor, ingresa un correo valido."

  @wip
  Escenario: US2-06 No puedo registrarme con un correo que no incluye caracteres despues del punto
    Dado que mi usuario es "juan" y no estoy registrado
    Cuando envio el comando "/registrar @juan@gmail."
    Entonces el bot muestra el mensaje "Por favor, ingresa un correo valido."
