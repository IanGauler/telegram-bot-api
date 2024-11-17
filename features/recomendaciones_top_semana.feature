# language: es
Característica:
Como usuario
quiero recibir recomendaciones de las canciones populares de la semana
para estar al día con las canciones más escuchadas

Escenario: US11-01 Recibir recomendaciones un dia de la semana laboral
Dado que hoy es un dia de la semana laboral
Y que en la plataforma existen "7" canciones
Y que las primeras "5" son las mas escuchadas de las semana laboral
Cuando envío el comando "/recomendaciones"
Entonces el bot muestra las primeras "5" canciones

@wip
Escenario: US11-02 Recibir recomendaciones un dia del fin de semana
Dado que hoy es un dia del fin de semana
Y que en la plataforma existen "7" canciones
Y que las primeras "5" son las mas escuchadas de los fines de semana
Cuando envío el comando "/recomendaciones"
Entonces el bot muestra las primeras "5" canciones

@wip
Escenario: US11-03 Recibir recomendaciones cuando no hay canciones reproducidas
Dado que hoy es un dia de la semana laboral
Y que en la plataforma existen "7" canciones
Y que no hay canciones escuchadas durante la semana laboral
Cuando envío el comando "/recomendaciones"
Entonces el bot muestra el mensaje "No hay recomendaciones de canciones disponibles en este momento. Escucha una para ayudar a la comunidad"

@wip
Escenario: US11-04 Recibir recomendaciones cuando hay menos de 5 canciones reproducidas
Dado que hoy es un dia de la semana laboral
Y que en la plataforma existen "7" canciones
Y que las primeras "3" son las mas escuchadas de la semana laboral
Y que las otras "4" no tienen reproducciones
Cuando envío el comando "/recomendaciones"
Entonces el bot muestra las primeras "3" canciones
