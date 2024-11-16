require 'integration_helper'
require_relative '../../dominio/usuario'
require_relative '../../persistencia/repositorio_usuarios'

describe RepositorioUsuarios do
  it 'deberia guardar un usuario nuevo con id e email' do
    juan = Usuario.new('1', 'juan@test.com')
    described_class.new.save(juan)
    expect(juan.id).equal?('1')
    expect(juan.email).equal?('juan@test.com')
  end

  it 'deberia recuperar todos' do
    repositorio = described_class.new
    cantidad_de_usuarios_iniciales = repositorio.all.size
    juan = Usuario.new('1', 'juan@test.com')
    repositorio.save(juan)
    expect(repositorio.all.size).to be(cantidad_de_usuarios_iniciales + 1)
  end

  it 'deberia obtener el usuario con el mail dado' do
    repositorio = described_class.new
    email = 'juan@test.com'
    juan = Usuario.new('1', email)
    repositorio.save(juan)
    usuario = repositorio.obtener_usuario_por_email(email)
    expect(usuario.id).to eq('1')
  end
end
