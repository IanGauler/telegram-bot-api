require 'integration_helper'
require_relative '../../dominio/cancion'
require_relative '../../persistencia/repositorio_canciones'

describe RepositorioCanciones do
  respositorio_canciones = described_class.new

  it 'deberia guardar una cancion nueva' do
    artistas = 'Shakira'
    cancion = Cancion.new('Waka-Waka', artistas, 2010, '3:31')
    respositorio_canciones.save(cancion)
    canciones = respositorio_canciones.all
    expect(canciones.size).to be 1
  end

  describe 'ultimas_canciones' do
    it 'deberia devolver las últimas 5 canciones agregadas' do
      respositorio_canciones.delete_all
      (1..7).each do |i|
        respositorio_canciones.save(Cancion.new("Cancion#{i}", "Artista#{i}", 2020, '2:00'))
      end
      ultimas_canciones = respositorio_canciones.ultimas_canciones(5)
      expect(ultimas_canciones.size).to be 5
    end
  end

  describe 'obtener_cancion_por_id' do
    it 'deberia devolver los detalles de una cancion a partir de su id' do
      cancion = Cancion.new('Cancion1', 'Artista1', 2020, '2:00')
      respositorio_canciones.save(cancion)
      id = respositorio_canciones.all.first.id
      cancion_obtenida = respositorio_canciones.obtener_cancion_por_id(id)

      expect(cancion_obtenida.titulo).to eq 'Cancion1'
      expect(cancion_obtenida.artistas).to eq 'Artista1'
      expect(cancion_obtenida.anio).to eq 2020
    end
  end
end
