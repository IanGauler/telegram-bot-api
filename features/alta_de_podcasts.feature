# language: es
Característica:
Como miembro del equipo de desarrollo
quiero una API que me permita dar de alta podcasts nuevos en la plataforma
para tener siempre disponible el catalogo de podcast actualizado

Antecedentes:
Dado que no hay podcasts en la plataforma

Escenario: US8-01 Dar de alta un podcast en la plataforma
Dado que quiero cargar el podcast "Caja Negra" de "Filo.news" lanzado en el año "2020" con "2" episodios
Cuando publico en la API con "/podcasts"
Entonces el podcast "Caja Negra" es dado de alta

@wip
Escenario: US8-02 Dar de alta dos podcast en la plataforma
Dado que quiero cargar el podcast "Caja Negra" de "Filo.news" lanzado en el año "2020" con "2" episodios
Y que quiero cargar el podcast "La Cruda" de "Spotify Studios" lanzado en el año "2020" con "2" episodios
Cuando publico en la API con "/podcasts"
Entonces el podcast "Caja Negra" es dado de alta
Y el podcast "La Cruda" es dado de alta
