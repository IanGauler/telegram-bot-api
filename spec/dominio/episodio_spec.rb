require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/episodio'
require_relative '../../dominio/errores/errores_contenido'

describe Episodio do
  it 'deberia crear un episodio' do
    podcast = Podcast.new('Caja Negra', 'Filo.news', 2021)
    episodio = described_class.new(podcast, 'Caja Negra - Ep1', 'Filo.news', '45:20')
    expect(episodio).to be_a(described_class)
  end

  it 'deberia representarse como hash' do
    podcast = Podcast.new('Caja Negra', 'Filo.news', 2021)
    episodio = described_class.new(podcast, 'Caja Negra - Ep1', 'Filo.news', '45:20', 1)
    expect(episodio.representacion_hash).to eq({ id: 1, titulo: 'Caja Negra - Ep1', participantes: 'Filo.news', duracion: '45:20' })
  end

  it 'deberia lanzar error TituloVacioEpisodio si el titulo es vacio' do
    podcast = Podcast.new('Caja Negra', 'Filo.news', 2021)
    expect { described_class.new(podcast, '', 'Filo.news', '45:20') }.to raise_error(TituloVacioEpisodio)
  end

  it 'deberia lanzar error ParticipantesVacioEpisodio si el "participantes" es vacio' do
    podcast = Podcast.new('Caja Negra', 'Filo.news', 2021)
    expect { described_class.new(podcast, 'Caja Negra', '', '45:20') }.to raise_error(ParticipantesVacioEpisodio)
  end

  it 'deberia lanzar error DuracionVaciaEpisodio si la "duracion" es vacia' do
    podcast = Podcast.new('Caja Negra', 'Filo.news', 2021)
    expect { described_class.new(podcast, 'Caja Negra', 'Filo.news', '') }.to raise_error(DuracionVaciaEpisodio)
  end

  it 'deberia lanzar error FormatoInvalidoDuracionEpisodio si la "duracion" no tiene formato MM:SS' do
    podcast = Podcast.new('Caja Negra', 'Filo.news', 2021)
    expect { described_class.new(podcast, 'Caja Negra', 'Filo.news', ':33') }.to raise_error(FormatoInvalidoDuracionEpisodio)
  end

  it 'deberia lanzar error FormatoInvalidoDuracionEpisodio si la "duracion" tiene segundos invalidos' do
    podcast = Podcast.new('Caja Negra', 'Filo.news', 2021)
    expect { described_class.new(podcast, 'Caja Negra', 'Filo.news', '3:91') }.to raise_error(FormatoInvalidoDuracionEpisodio)
  end

  it 'deberia lanzar error FormatoInvalidoDuracionEpisodio si la "duracion" no es un string' do
    podcast = Podcast.new('Caja Negra', 'Filo.news', 2021)
    expect { described_class.new(podcast, 'Caja Negra', 'Filo.news', 5) }.to raise_error(FormatoInvalidoDuracionEpisodio)
  end

  it 'deberia lanzar error FormatoInvalidoDuracionEpisodio si la "duracion" tiene minutos que empiezan en 0' do
    podcast = Podcast.new('Caja Negra', 'Filo.news', 2021)
    expect { described_class.new(podcast, 'Caja Negra', 'Filo.news', '0:31') }.to raise_error(FormatoInvalidoDuracionEpisodio)
  end
end
