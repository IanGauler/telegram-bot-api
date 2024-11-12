require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/sistema'
require_relative '../../persistencia/repositorio_usuarios'
require_relative '../../persistencia/repositorio_canciones'
require_relative '../../persistencia/abstract_repository'

describe Sistema do
  juan_email = 'juan@test.com'
  juan_id = 1
  repositorio_usuarios = RepositorioUsuarios.new
  repositorio_canciones = RepositorioCanciones.new
  sistema = described_class.new(repositorio_usuarios, repositorio_canciones)

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
  end

  describe 'obtener_novedades' do
    it 'deberia devolver las canciones agregadas si hay menos de 6' do
      crear_canciones(3, sistema)
      expect(sistema.obtener_novedades.size).to eq 3
    end
  end
end

def crear_canciones(cantidad, sistema)
  (1..cantidad).each do |i|
    sistema.crear_cancion("Cancion#{i}", "Artista#{i}", 2020, '2:00')
  end
end
