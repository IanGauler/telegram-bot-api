require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/episodio'
require_relative '../../dominio/errores/errores_contenido'

describe Episodio do
  it 'deberia crear un episodio si todos sus parametros son validos' do
    episodio = described_class.new('Caja Negra - Ep1', 'Filo.news', '45:20')
    expect(episodio).to be_a(described_class)
  end

  it 'deberia representarse como hash' do
    episodio = described_class.new('Caja Negra - Ep1', 'Filo.news', '45:20', 1)
    expect(episodio.representacion_hash).to eq({ id: 1, titulo: 'Caja Negra - Ep1', participantes: 'Filo.news', duracion: '45:20' })
  end

  it 'deberia lanzar error TituloVacioEpisodio si el titulo es vacio' do
    expect { described_class.new('', 'Filo.news', '45:20') }.to raise_error(TituloVacioEpisodio)
  end

  it 'deberia lanzar error ParticipantesVacioEpisodio si el "participantes" es vacio' do
    expect { described_class.new('Caja Negra', '', '45:20') }.to raise_error(ParticipantesVacioEpisodio)
  end

  it 'deberia lanzar error DuracionVaciaEpisodio si la "duracion" es vacia' do
    expect { described_class.new('Caja Negra', 'Filo.news', '') }.to raise_error(DuracionVaciaEpisodio)
  end

  it 'deberia lanzar error FormatoInvalidoDuracion si la "duracion" no tiene formato MM:SS' do
    expect { described_class.new('Caja Negra', 'Filo.news', ':33') }.to raise_error(FormatoInvalidoDuracion)
  end

  it 'deberia lanzar error FormatoInvalidoDuracion si la "duracion" tiene segundos invalidos' do
    expect { described_class.new('Caja Negra', 'Filo.news', '3:91') }.to raise_error(FormatoInvalidoDuracion)
  end

  it 'deberia lanzar error ErrorEpisodioInvalido si la "duracion" no es un string' do
    expect { described_class.new('Caja Negra', 'Filo.news', 5) }.to raise_error(ErrorEpisodioInvalido)
  end

  it 'deberia lanzar error FormatoInvalidoDuracion si la "duracion" tiene minutos que empiezan en 0' do
    expect { described_class.new('Caja Negra', 'Filo.news', '0:31') }.to raise_error(FormatoInvalidoDuracion)
  end

  it 'deberia lanzar error ErrorEpisodioInvalido si alguno de los parametros es nil' do
    expect { described_class.new('Caja Negra', nil, '20:31') }.to raise_error(ErrorEpisodioInvalido)
  end

  it 'deberia lanzar error ErrorEpisodioInvalido si el titulo no es string' do
    expect { described_class.new(5, 'Filo.news', '20:31') }.to raise_error(ErrorEpisodioInvalido)
  end

  it 'deberia lanzar error ErrorEpisodioInvalido si el Participantes no es string' do
    expect { described_class.new('Caja negra', 5, '20:31') }.to raise_error(ErrorEpisodioInvalido)
  end
end
