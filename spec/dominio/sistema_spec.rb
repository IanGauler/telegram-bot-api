require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/sistema'
require_relative '../../persistencia/repositorio_usuarios'
require_relative '../../persistencia/repositorio_canciones'
require_relative '../../persistencia/abstract_repository'
require_relative '../../persistencia/repositorio_reproducciones'
require_relative '../../persistencia/repositorio_megustas'

describe Sistema do
  juan_email = 'juan@test.com'
  juan_id = '1'
  repositorio_usuarios = RepositorioUsuarios.new
  repositorio_canciones = RepositorioCanciones.new
  repositorio_reproducciones = RepositorioReproducciones.new
  repositorio_megustas = RepositorioMegustas.new
  sistema = described_class.new(repositorio_usuarios, repositorio_canciones, repositorio_reproducciones, repositorio_megustas)

  describe 'resetear' do
    it 'deberia vaciar el repositorio de usuarios y canciones' do
      sistema.crear_usuario(juan_id, juan_email)
      sistema.crear_cancion('Waka-Waka', 'Shakira', 2010, '3:31')
      sistema.resetear
      expect(sistema.usuarios.size).to eq 0
      expect(sistema.canciones.size).to eq 0
    end
  end

  describe 'crear_usuario' do
    it 'deberia crear un usuario' do
      sistema.crear_usuario(juan_id, juan_email)
      expect(sistema.usuarios.size).to eq 1
    end

    it 'deberia lanzar UsuarioYaRegistrado si el usuario ya existe' do
      sistema.crear_usuario(juan_id, juan_email)
      expect { sistema.crear_usuario(juan_id, juan_email) }.to raise_error(UsuarioYaRegistrado)
    end

    it 'deberia lanzar MailYaRegistrado si ya hay un usuario con ese mail' do
      sistema.crear_usuario(juan_id, juan_email)
      expect { sistema.crear_usuario('2', juan_email) }.to raise_error(MailYaRegistrado)
    end
  end

  describe 'obtener_novedades' do
    it 'deberia devolver las canciones agregadas si hay menos de 6' do
      crear_canciones(3, sistema)
      expect(sistema.obtener_novedades.size).to eq 3
    end

    it 'deberia devolver las últimas 5 canciones agregadas si hay 7 canciones' do
      crear_canciones(7, sistema)
      expect(sistema.obtener_novedades.size).to eq 5
    end
  end

  describe 'obtener_datos_cancion_por_id' do
    it 'deberia devolver los detalles de una cancion a partir de su id' do
      crear_canciones(1, sistema)
      id = sistema.canciones.first.id
      cancion = sistema.obtener_datos_cancion_por_id(id)

      expect(cancion.titulo).to eq 'Cancion1'
      expect(cancion.artistas).to eq 'Artista1'
      expect(cancion.anio).to eq 2020
    end

    it 'deberia lanzar error de CancionNoEncontrada si la cancion no existe' do
      expect { sistema.obtener_datos_cancion_por_id(1) }.to raise_error(CancionNoEncontrada)
    end
  end

  describe 'registrar_reproduccion' do
    it 'deberia registrar una reproduccion' do
      sistema.crear_usuario(juan_id, juan_email)
      sistema.crear_cancion('Waka Waka', 'Shakira', 2010, '3:31')
      cancion = sistema.canciones.first

      sistema.registrar_reproduccion(juan_email, cancion.id)
      expect(sistema.reproducciones.size).to eq 1

      reproduccion = sistema.reproducciones.first
      expect(reproduccion.id_usuario).to eq juan_id
      expect(reproduccion.id_cancion).to eq cancion.id
    end

    it 'deberia lanzar error si el email no esta asociado a un usuario registrado' do
      sistema.crear_cancion('Waka Waka', 'Shakira', 2010, '3:31')
      cancion = sistema.canciones.first
      expect { sistema.registrar_reproduccion(juan_email, cancion.id) }.to raise_error(UsuarioNoRegistrado)
    end

    it 'deberia lanzar error si el id de la cancion no existe en el sistema' do
      sistema.crear_usuario(juan_id, juan_email)
      expect { sistema.registrar_reproduccion(juan_email, 1) }.to raise_error(CancionNoEncontrada)
    end
  end

  describe 'registrar_megusta' do
    it 'deberia devolver error si el id de la cancion no existe en el sistema' do
      sistema.crear_usuario(juan_id, juan_email)
      expect { sistema.registrar_megusta(juan_id, 1) }.to raise_error(CancionNoEncontrada)
    end

    it 'deberia devolver error si el usuario no ha escuchado la cancion' do
      sistema.crear_usuario(juan_id, juan_email)
      sistema.crear_cancion('Waka Waka', 'Shakira', 2010, '3:31')
      cancion = sistema.canciones.first

      expect { sistema.registrar_megusta(juan_id, cancion.id) }.to raise_error(CancionNoEscuchada)
    end

    it 'deberia registrar un me gusta' do
      sistema.crear_usuario(juan_id, juan_email)
      sistema.crear_cancion('Waka Waka', 'Shakira', 2010, '3:31')
      sistema.registrar_reproduccion(juan_email, sistema.canciones.first.id)

      sistema.registrar_megusta(juan_id, sistema.canciones.first.id)
      expect(sistema.megustas.size).to eq 1

      megusta = sistema.reproducciones.first
      expect(megusta.id_usuario).to eq juan_id
      expect(megusta.id_cancion).to eq sistema.canciones.first.id
    end
  end
end

def crear_canciones(cantidad, sistema)
  (1..cantidad).each do |i|
    sistema.crear_cancion("Cancion#{i}", "Artista#{i}", 2020, '2:00')
  end
end
