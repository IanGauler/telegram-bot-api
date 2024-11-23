require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/sistema'
Dir[File.join(__dir__, '../../persistencia', '*.rb')].each { |file| require file }

describe Sistema do
  juan_email = 'juan@test.com'
  juan_id = '1'
  repositorio_usuarios = RepositorioUsuarios.new
  repositorio_reproducciones = RepositorioReproducciones.new
  repositorio_megustas = RepositorioMeGustas.new
  administrador_de_contenido = AdministradorDeContenido.new(RepositorioContenido.new, RepositorioCanciones.new, RepositorioPodcasts.new, RepositorioEpisodios.new)
  sistema = described_class.new(repositorio_usuarios, administrador_de_contenido, repositorio_reproducciones, repositorio_megustas)
  dia_de_semana = Date.new(2024, 11, 14)
  dia_fin_de_semana = Date.new(2024, 11, 17)

  describe 'resetear' do
    it 'deberia vaciar el repositorio de usuarios y canciones' do
      sistema.crear_usuario(juan_id, juan_email)
      sistema.crear_cancion('Waka-Waka', 'Shakira', 2010, '3:31')
      sistema.resetear
      expect(sistema.usuarios.size).to eq 0
      expect(sistema.canciones.size).to eq 0
    end
  end

  describe 'crear_usuario' do
    it 'deberia crear un usuario' do
      sistema.crear_usuario(juan_id, juan_email)
      expect(sistema.usuarios.size).to eq 1
    end

    it 'deberia lanzar UsuarioYaRegistrado si el usuario ya existe' do
      sistema.crear_usuario(juan_id, juan_email)
      expect { sistema.crear_usuario(juan_id, juan_email) }.to raise_error(UsuarioYaRegistrado)
    end

    it 'deberia lanzar MailYaRegistrado si ya hay un usuario con ese mail' do
      sistema.crear_usuario(juan_id, juan_email)
      expect { sistema.crear_usuario('2', juan_email) }.to raise_error(MailYaRegistrado)
    end
  end

  describe 'obtener_novedades' do
    it 'deberia devolver las canciones agregadas si hay menos de 6' do
      crear_canciones(3, sistema)
      expect(sistema.obtener_novedades.size).to eq 3
    end

    it 'deberia devolver las últimas 5 canciones agregadas si hay 7 canciones' do
      crear_canciones(7, sistema)
      expect(sistema.obtener_novedades.size).to eq 5
    end
  end

  describe 'obtener_contenido_por_id' do
    it 'deberia devolver los detalles de una cancion a partir de su id' do
      crear_canciones(1, sistema)
      id = sistema.canciones.first.id
      cancion = sistema.obtener_contenido_por_id(id)

      expect(cancion.titulo).to eq 'Cancion1'
      expect(cancion.artistas).to eq 'Artista1'
      expect(cancion.anio).to eq 2020
    end

    it 'deberia lanzar error de ContenidoNoEncontrado si la cancion no existe' do
      expect { sistema.obtener_contenido_por_id(1) }.to raise_error(ContenidoNoEncontrado)
    end
  end

  describe 'registrar_reproduccion' do
    it 'deberia registrar una reproduccion' do
      sistema.crear_usuario(juan_id, juan_email)
      sistema.crear_cancion('Waka Waka', 'Shakira', 2010, '3:31')
      cancion = sistema.canciones.first

      sistema.registrar_reproduccion(juan_email, cancion.id)
      expect(sistema.reproducciones.size).to eq 1

      reproduccion = sistema.reproducciones.first
      expect(reproduccion.usuario.id).to eq juan_id
      expect(reproduccion.contenido.id).to eq cancion.id
    end

    it 'deberia lanzar error si el email no esta asociado a un usuario registrado' do
      sistema.crear_cancion('Waka Waka', 'Shakira', 2010, '3:31')
      cancion = sistema.canciones.first
      expect { sistema.registrar_reproduccion(juan_email, cancion.id) }.to raise_error(UsuarioNoRegistrado)
    end
  end

  describe 'registrar_megusta' do
    it 'deberia devolver error si el id de la cancion no existe en el sistema' do
      sistema.crear_usuario(juan_id, juan_email)
      expect { sistema.registrar_megusta(juan_id, 1) }.to raise_error(CancionNoEncontrada)
    end

    it 'deberia devolver error si el usuario no ha escuchado la cancion' do
      sistema.crear_usuario(juan_id, juan_email)
      sistema.crear_cancion('Waka Waka', 'Shakira', 2010, '3:31')
      cancion = sistema.canciones.first

      expect { sistema.registrar_megusta(juan_id, cancion.id) }.to raise_error(CancionNoEscuchada)
    end

    it 'deberia registrar un me gusta' do
      sistema.crear_usuario(juan_id, juan_email)
      sistema.crear_cancion('Waka Waka', 'Shakira', 2010, '3:31')
      sistema.registrar_reproduccion(juan_email, sistema.canciones.first.id)

      sistema.registrar_megusta(juan_id, sistema.canciones.first.id)
      expect(sistema.megustas.size).to eq 1

      megusta = sistema.megustas.first
      expect(megusta.usuario.id).to eq juan_id
      expect(megusta.cancion.id).to eq sistema.canciones.first.id
    end
  end

  describe 'recomendaciones_de_la_semana' do
    it 'deberia devolver las 5 canciones mas escuchadas de la semana' do
      crear_canciones(10, sistema)
      canciones_reproducidas = reproducir_canciones(5, sistema, dia_de_semana)

      allow(Date).to receive(:today).and_return(dia_de_semana)
      recomendaciones = sistema.recomendaciones_de_la_semana
      expect(recomendaciones.size).to eq 5
      canciones_reproducidas.each do |c|
        expect(recomendaciones.any? { |r| r.titulo == c.titulo }).to be true
      end
    end

    it 'deberia devolver las 5 canciones mas escuchadas del fin de semana' do
      crear_canciones(10, sistema)
      canciones_reproducidas_finde = reproducir_canciones(5, sistema, dia_fin_de_semana)

      allow(Date).to receive(:today).and_return(dia_fin_de_semana)
      recomendaciones = sistema.recomendaciones_de_la_semana
      expect(recomendaciones.size).to eq 5
      recomendaciones.each do |r|
        expect(canciones_reproducidas_finde.any? { |c| r.titulo == c.titulo }).to be true
      end
    end

    it 'deberia devolver nada si no hay canciones escuchadas' do
      crear_canciones(5, sistema)
      reproducir_canciones(5, sistema, dia_de_semana)

      allow(Date).to receive(:today).and_return(dia_fin_de_semana)
      recomendaciones = sistema.recomendaciones_de_la_semana
      expect(recomendaciones.size).to eq 0
    end

    it 'deberia devolver solo canciones escuchadas en el fin de semana' do
      crear_canciones(5, sistema)
      reproducir_canciones(3, sistema, dia_de_semana)
      canciones_reproducidas_finde = reproducir_canciones(2, sistema, dia_fin_de_semana, 3)

      allow(Date).to receive(:today).and_return(dia_fin_de_semana)
      expect(sistema.recomendaciones_de_la_semana.size).to eq 2
      sistema.recomendaciones_de_la_semana.each do |r|
        expect(canciones_reproducidas_finde.any? { |c| r.titulo == c.titulo }).to be true
      end
    end
  end

  describe 'reproducir_episodio' do
    it 'deberia registrar una reproduccion de un episodio' do
      sistema.crear_usuario(juan_id, juan_email)
      episodios = [{ titulo: 'Ep1', participantes: 'Filo.news', duracion: '45:20' }]
      sistema.crear_podcast('Caja Negra', 'Filo.news', 2022, episodios)
      podcast = sistema.podcasts.first
      sistema.registrar_reproduccion_episodio(juan_email, podcast.episodios.first.id, podcast.id)

      expect(sistema.reproducciones.size).to eq 1
      reproduccion = sistema.reproducciones.first
      expect(reproduccion.usuario.id).to eq juan_id
      expect(reproduccion.contenido.id).to eq podcast.episodios.first.id
    end
  end
end

def crear_canciones(cantidad, sistema)
  (1..cantidad).each do |i|
    sistema.crear_cancion("Cancion#{i}", "Artista#{i}", 2020, '2:00')
  end
end

def reproducir_canciones(cantidad, sistema, fecha = Date.today, offset = 0)
  allow(Date).to receive(:today).and_return(fecha)
  mail = 'mail@mail.com'
  sistema.crear_usuario('1', mail) unless sistema.usuarios.any? { |u| u.email == mail }

  canciones_a_reproducir = sistema.canciones[offset, cantidad]
  canciones_a_reproducir.each do |c|
    sistema.registrar_reproduccion(mail, c.id)
  end
  canciones_a_reproducir
end
