require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'sinatra/custom_logger'
require_relative './config/configuration'
require_relative './config/log_middleware'
require_relative './lib/version'
require_relative './conectores/conector_spotify'
require 'dotenv/load'
Dir[File.join(__dir__, 'dominio', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'persistencia', '*.rb')].each { |file| require file }

configure do
  customer_logger = Configuration.logger
  DB = Configuration.db # rubocop:disable  Lint/ConstantDefinitionInBlock
  DB.loggers << customer_logger
  set :logger, customer_logger
  set :default_content_type, :json
  set :environment, ENV['APP_MODE'].to_sym
  administrador_de_contenido = AdministradorDeContenido.new(RepositorioContenido.new, RepositorioCanciones.new, RepositorioPodcasts.new, RepositorioEpisodios.new)
  proveedor_de_recomendaciones = ConectorSpotify.new(ENV['SPOTIFY_API_URL'], ENV['SPOTIFY_ACCOUNT_API_URL'], customer_logger)
  set :sistema, Sistema.new(RepositorioUsuarios.new, administrador_de_contenido, RepositorioReproducciones.new, RepositorioMeGustas.new, proveedor_de_recomendaciones)
  use LogMiddleware
  customer_logger.info("Aplicación iniciada en modo #{settings.environment}")
end

before do
  if !request.body.nil? && request.body.size.positive?
    request.body.rewind
    @params = JSON.parse(request.body.read, symbolize_names: true)
  end
end

def sistema
  settings.sistema
end

get '/version' do
  status 200
  json({ version: Version.current })
end

post '/reset' do
  sistema.resetear
  status 200
end

get '/usuarios' do
  usuarios = sistema.usuarios
  respuesta = []
  usuarios.map { |u| respuesta << { email: u.email, id: u.id } }

  status 200
  json(respuesta)
end

post '/usuarios' do
  usuario = sistema.crear_usuario(@params[:id].to_s, @params[:email])
  status 201
  { id: usuario.id, email: usuario.email }.to_json
rescue UsuarioYaRegistrado, MailYaRegistrado => e
  status 409
  { error: e.message }.to_json
end

post '/canciones' do
  @params.each do |c|
    sistema.crear_cancion(c[:titulo], c[:artistas], c[:anio], c[:duracion])
  end
  status 201
rescue ErrorValidacion, ErrorCancionInvalida => e
  status 400
  { error: e.message }.to_json
end

get '/canciones' do
  canciones = sistema.canciones
  respuesta = []
  canciones.map do |c|
    respuesta << { titulo: c.titulo, artistas: c.artistas, anio: c.anio, duracion: c.duracion, id: c.id }
  end
  status 200
  json(respuesta)
end

get '/novedades' do
  contenidos = sistema.obtener_novedades
  respuesta = []
  contenidos.map do |c|
    respuesta << c.representacion_hash
  end
  status 200
  json(respuesta)
end

get '/contenidos/:id_contenido' do
  contenido = sistema.obtener_contenido_por_id(params['id_contenido'].to_i)
  representacion_hash_contenido = contenido.representacion_hash
  status 200
  json(representacion_hash_contenido)
rescue ContenidoNoEncontrado => e
  status 404
  { error: e.message }.to_json
end

post '/contenidos/:id_contenido/megusta' do
  sistema.registrar_megusta(@params[:id_usuario].to_s, params['id_contenido'].to_i)
  status 201
rescue ContenidoNoEncontrado, UsuarioNoRegistrado, NoSePuedeDarMeGustaAEpisodios => e
  status 404
  { error: e.message }.to_json
rescue ContenidoNoEscuchado => e
  status 409
  { error: e.message }.to_json
end

post '/canciones/:id_cancion/reproduccion' do
  id_cancion = params['id_cancion'].to_i
  sistema.registrar_reproduccion(@params[:email], id_cancion)
  status 201
rescue UsuarioNoRegistrado, ContenidoNoEncontrado => e
  status 404
  { error: e.message }.to_json
end

get '/reproducciones' do
  reproducciones = sistema.reproducciones
  respuesta = []
  reproducciones.map do |r|
    respuesta << { id_usuario: r.usuario.id, id_contenido: r.contenido.id }
  end
  status 200
  json(respuesta)
end

get '/megustas' do
  megustas = sistema.megustas
  respuesta = []
  megustas.map do |me_gusta|
    respuesta << { id_usuario: me_gusta.usuario.id, id_contenido: me_gusta.contenido.id }
  end
  status 200
  json(respuesta)
end

post '/podcasts' do
  @params.each do |podcast|
    sistema.crear_podcast(podcast[:titulo], podcast[:creador], podcast[:anio], podcast[:episodios])
  end
  status 201
rescue ErrorValidacion, ErrorPodcastInvalido, ErrorEpisodioInvalido, EpisodiosVacios => e
  status 400
  { error: e.message }.to_json
end

get '/podcasts' do
  podcasts = sistema.podcasts
  respuesta = []
  podcasts.map do |podcast|
    episodios = []
    podcast.episodios.map do |episodio|
      episodios << { id: episodio.id, titulo: episodio.titulo, participantes: episodio.participantes, duracion: episodio.duracion }
    end
    respuesta << { id: podcast.id, titulo: podcast.titulo, creador: podcast.creador, anio: podcast.anio, episodios: }
  end
  status 200
  json(respuesta)
end

get '/recomendaciones' do
  recomendaciones = sistema.recomendaciones_de_la_semana
  respuesta = []
  recomendaciones.map do |r|
    respuesta << { titulo: r.titulo, artistas: r.artistas, anio: r.anio, duracion: r.duracion, id: r.id }
  end
  status 200
  json(respuesta)
end

post '/podcasts/:id_podcast/episodio/:id_episodio/reproduccion' do
  id_podcast = params['id_podcast'].to_i
  id_episodio = params['id_episodio'].to_i

  sistema.registrar_reproduccion_episodio(@params[:email], id_episodio, id_podcast)

  status 201
rescue UsuarioNoRegistrado, ContenidoNoEncontrado, EpisodioNoPerteneceAPodcast => e
  status 404
  { error: e.message }.to_json
end

post '/contenidos/:id_contenido/playlist' do
  id_contenido = params['id_contenido'].to_i
  id_usuario = @params[:id_usuario].to_s

  contenido = sistema.agregar_contenido_a_playlist(id_usuario, id_contenido)
  representacion_hash_contenido = contenido.representacion_hash

  status 201
  json(representacion_hash_contenido)
rescue ContenidoNoEncontrado => e
  status 404
  { error: e.message }.to_json
rescue AgregarPodcastAPlaylist, ContenidoDuplicadoPlaylist => e
  status 409
  { error: e.message }.to_json
end

get '/usuarios/:id_usuario/playlist' do
  id_usuario = params[:id_usuario].to_s

  playlist = sistema.obtener_playlist(id_usuario)
  contenidos = playlist.contenidos.map(&:representacion_hash)
  status 200
  json(contenidos)
rescue UsuarioNoRegistrado => e
  status 404
  { error: e.message }.to_json
end

get '/usuarios/:id_usuario/recomendaciones/artistas' do
  id_usuario = params[:id_usuario].to_s
  recomendaciones = sistema.recomendar_artistas(id_usuario)
  status 200
  json(recomendaciones)
rescue UsuarioNoRegistrado => e
  status 404
  { error: e.message }.to_json
rescue ContenidoNoEscuchado => e
  status 409
  { error: e.message }.to_json
rescue RecomendacionesNoDisponibles => e
  status 503
  { error: e.message }.to_json
end

error do
  e = env['sinatra.error']
  status 500
  json({ error: "Error inesperado al procesar la request: #{e.message}" })
end
