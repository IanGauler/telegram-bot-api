# language: es

Característica:
  Como usuario
  quiero registrarme en el bot con un nombre de usuario y un correo electronico
  para que el sistema pueda personalizar mis recomendaciones y guardar mi actividad.

Escenario: US1-01 Registro exitoso de un nuevo usuario
  Dado que mi usuario es "juan", mi id es "1" y no estoy registrado
  Cuando envio el comando "/registrar" con email "juan@gmail.com"
  Entonces el bot muestra el mensaje "Bienvenido, juan"
