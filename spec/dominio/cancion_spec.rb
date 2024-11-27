require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/cancion'

describe Cancion do
  it 'deberia crear una cancion' do
    cancion = described_class.new('Waka-Waka', 'Shakira', 2010, '3:31')
    expect(cancion).to be_a(described_class)
  end

  it 'deberia representarse como hash' do
    cancion = described_class.new('Waka-Waka', 'Shakira', 2010, '3:31', 1)
    expect(cancion.representacion_hash).to eq({ titulo: 'Waka-Waka', artistas: 'Shakira', anio: 2010, duracion: '3:31', id: 1 })
  end

  it 'debería lanzar error si el título es vacío' do
    expect { described_class.new('', 'Shakira', 2010, '3:31') }.to raise_error(TituloVacio)
  end

  it 'debería lanzar error si los artistas son vacíos' do
    expect { described_class.new('Waka-Waka', '', 2010, '3:31') }.to raise_error(ArtistasVacios)
  end
end
