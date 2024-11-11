require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/sistema'
require_relative '../../persistencia/repositorio_usuarios'
require_relative '../../persistencia/abstract_repository'

describe Sistema do
  juan_email = 'juan@test.com'
  juan_id = 1

  describe 'eliminar_usuarios' do
    it 'deberia borrar vaciar el repositorio de usuarios' do
      repo = RepositorioUsuarios.new
      sistema = described_class.new(repo)
      sistema.crear_usuario(juan_id, juan_email)
      sistema.eliminar_usuarios
      expect(sistema.usuarios.size).to eq 0
    end
  end

  describe 'crear_usuario' do
    it 'deberia crear un usuario' do
      repo = RepositorioUsuarios.new
      sistema = described_class.new(repo)
      sistema.crear_usuario(juan_id, juan_email)
    end

    it 'deberia lanzar UsuarioYaRegistrado si el usuario ya existe' do
      repo = RepositorioUsuarios.new
      sistema = described_class.new(repo)
      sistema.crear_usuario(juan_id, juan_email)
      expect { sistema.crear_usuario(juan_id, juan_email) }.to raise_error(UsuarioYaRegistrado)
    end
  end

  describe 'crear_cancion' do
    xit 'deberia crear una cancion' do
      repo = RepositorioCanciones.new
      sistema = described_class.new(RepositorioUsuarios.new, repo)
      sistema.crear_cancion('Waka-Waka', 'Shakira', 2010, '3:31')
    end
  end
end
