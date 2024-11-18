# language: es
Característica:
  Como usuario
  quiero consultar detalles de una cancion
  para tener mas informacion de la misma

  Antecedentes:
    Dado que mi usuario es "juan" con id "1" y mail "juan@gmail.com", y estoy registrado
    Y que existe la cancion "Waka Waka"

  Escenario: US5-01 Consulta de detalles de una cancion existente
    Cuando envío el comando "/detalles" con el id de la cancion WakaWaka
    Entonces el bot muestra los detalles
    """
    Titulo: WakaWaka
    Artista: Shakira
    Año: 2010
    Duración: 3:31
    """

  Escenario: US5-02 Consulta de una cancion inexistente
    Cuando envio el comando "/detalles" con el id de una cancion inexistente
    Entonces el bot muestra el mensaje de error "El contenido no fue encontrado."
