require_relative './modulos_sistema/sistema_usuario'
require_relative './modulos_sistema/sistema_canciones'
require_relative './modulos_sistema/sistema_reproducciones'
require_relative './modulos_sistema/sistema_me_gusta'

class Sistema
  include SistemaUsuarios
  include SistemaCanciones
  include SistemaReproducciones
  include SistemaMeGusta

  CANTIDAD_NOVEDADES = 5
  def initialize(repositorio_usuarios, repositorio_canciones, repositorio_reproducciones, repositorio_megustas)
    @repositorio_usuarios = repositorio_usuarios
    @repositorio_canciones = repositorio_canciones
    @repositorio_reproducciones = repositorio_reproducciones
    @repositorio_megustas = repositorio_megustas
  end

  def resetear
    @repositorio_usuarios.delete_all
    @repositorio_canciones.delete_all
  end

  def obtener_novedades
    @repositorio_canciones.ultimas_canciones(CANTIDAD_NOVEDADES)
  end
end
