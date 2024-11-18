require_relative './modulos_sistema/sistema_usuario'
require_relative './modulos_sistema/sistema_contenido'
require_relative './modulos_sistema/sistema_reproducciones'
require_relative './modulos_sistema/sistema_me_gusta'
require_relative './novedades'

class Sistema
  include SistemaUsuarios
  include SistemaContenido
  include SistemaReproducciones
  include SistemaMeGusta

  CANTIDAD_NOVEDADES = 5
  def initialize(repositorio_usuarios, administrador_de_contenido, repositorio_reproducciones, repositorio_megustas)
    @repositorio_usuarios = repositorio_usuarios
    @administrador_de_contenido = administrador_de_contenido
    @repositorio_reproducciones = repositorio_reproducciones
    @repositorio_megustas = repositorio_megustas
  end

  def resetear
    @repositorio_usuarios.delete_all
    @administrador_de_contenido.resetear
  end

  def obtener_novedades
    novedades = Novedades.new(CANTIDAD_NOVEDADES)
    novedades.listar(@administrador_de_contenido.repositorio_contenidos)
  end

  def recomendaciones_de_la_semana
    @administrador_de_contenido.repositorio_canciones.canciones_top_semana(Date.today)
  end
end
