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

  it 'debería lanzar TituloVacio si el título es vacío' do
    expect { described_class.new('', 'Shakira', 2010, '3:31') }.to raise_error(TituloVacio)
  end

  it 'debería lanzar ArtistasVacios si los artistas son vacíos' do
    expect { described_class.new('Waka-Waka', '', 2010, '3:31') }.to raise_error(ArtistasVacios)
  end

  it 'debería lanzar DuracionVacia si la duracion es vacía' do
    expect { described_class.new('Waka-Waka', 'Shakira', 2010, '') }.to raise_error(DuracionVacia)
  end

  it 'debería lanzar AnioVacio si el anio es vacio' do
    expect { described_class.new('Waka-Waka', 'Shakira', '', '3:31') }.to raise_error(AnioVacio)
  end

  it 'deberia lanzar FormatoInvalidoDuracion si la duracion no tiene el formato MM:SS' do
    expect { described_class.new('Waka-Waka', 'Shakira', 2010, '3:3') }.to raise_error(FormatoInvalidoDuracion)
  end

  it 'deberia lanzar AnioInvalido si el anio es una cadena de texto no numerica' do
    expect { described_class.new('Waka-Waka', 'Shakira', 'Spaaaguetti', '3:31') }.to raise_error(AnioInvalido)
  end
end
