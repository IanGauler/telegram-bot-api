# language: es
Característica: Resetear repositorio

Escenario: R1 endpoint /reset elimina todos los usuarios
  Dado que tengo un usuario en el sistema
  Cuando pido post reset
  Entonces se eliminan todos los usuarios