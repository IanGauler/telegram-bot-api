require 'integration_helper'
require_relative '../../dominio/cancion'
require_relative '../../persistencia/repositorio_canciones'

describe RepositorioCanciones do
  xit 'deberia guardar una cancion nueva' do
    cancion = Cancion.new('Waka-Waka', 'Shakira', 2010, '3:31')
    described_class.new.save(cancion)
    expect(describe_class.all.size).to be 1
  end
end
