require 'integration_helper'
require 'spec_helper'
require_relative '../dominio/sistema'
require_relative '../persistencia/repositorio_usuarios'
require_relative '../persistencia/abstract_repository'

describe Sistema do
  describe 'eliminar_usuarios' do
    it 'deberia borrar vaciar el repositorio de usuarios' do
      repo = RepositorioUsuarios.new
      sistema = described_class.new(repo)
      sistema.crear_usuario('1', 'juan@test.com')
      sistema.eliminar_usuarios
      expect(sistema.usuarios.size).to eq 0
    end
  end
end
