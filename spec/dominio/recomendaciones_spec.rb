require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/recomendaciones'

describe Recomendaciones do
  cancion_semana = Cancion.new('titulo_semana', 'artista1', 2020, '2:00')
  cancion_finde = Cancion.new('titulo_finde', 'artista2', 2020, '2:00')

  it 'deberia devolver las canciones mas escuchadas de la semana' do
    repositorio_canciones = instance_double('repositorio_canciones')
    allow(repositorio_canciones).to receive(:top_escuchadas_para_dias).with('NOT IN (0, 6)', 5).and_return([cancion_semana])
    recomendaciones = described_class.new
    expect(recomendaciones.de_la_semana(Date.new(2024, 11, 20), repositorio_canciones)).to eq([cancion_semana])
  end

  it 'deberia devolver las canciones mas escuchadas del fin de semana' do
    repositorio_canciones = instance_double('repositorio_canciones')
    allow(repositorio_canciones).to receive(:top_escuchadas_para_dias).with('IN (0, 6)', 5).and_return([cancion_finde])
    recomendaciones = described_class.new
    expect(recomendaciones.de_la_semana(Date.new(2024, 11, 24), repositorio_canciones)).to eq([cancion_finde])
  end
end
