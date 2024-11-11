require 'integration_helper'
require_relative '../../dominio/cancion'
require_relative '../../persistencia/repositorio_canciones'

describe RepositorioCanciones do
  respositorio_canciones = described_class.new

  it 'deberia guardar una cancion nueva' do
    cancion = Cancion.new('Waka-Waka', 'Shakira', 2010, '3:31')
    respositorio_canciones.save(cancion)
    canciones = respositorio_canciones.all
    puts "cnaciones: #{canciones}"
    expect(respositorio_canciones.all.size).to be 1
  end
end
