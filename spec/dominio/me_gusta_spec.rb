require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/megusta'

describe MeGusta do
  it 'deberia crear un megusta' do
    reproduccion = instance_double('reproduccion')
    usuario = instance_double('usuario')
    cancion = instance_double('cancion')
    allow(reproduccion).to receive(:corresponde_a_usuario_y_contenido).with(usuario, cancion).and_return(true)
    reproduccion = described_class.new(usuario, cancion, reproduccion)
    expect(reproduccion).to be_a(described_class)
  end
end
