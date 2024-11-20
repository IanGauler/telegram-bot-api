require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'sinatra/custom_logger'
require_relative './config/configuration'
require_relative './lib/version'
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
  set :sistema, Sistema.new(RepositorioUsuarios.new, administrador_de_contenido, RepositorioReproducciones.new, RepositorioMegustas.new)
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
rescue StandardError => e
  status 500
  { error: "Error inesperado: #{e.message}" }.to_json
end

post '/canciones' do
  @params.each do |c|
    sistema.crear_cancion(c[:titulo], c[:artistas], c[:anio].to_i, c[:duracion])
  end
  status 201
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

post '/canciones/:id_cancion/reproduccion' do
  id_cancion = params['id_cancion'].to_i
  cancion = sistema.obtener_contenido_por_id(id_cancion)
  sistema.registrar_reproduccion(@params[:email], cancion)
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

post '/canciones/:id_cancion/megusta' do
  sistema.registrar_megusta(@params[:id_usuario].to_s, params['id_cancion'].to_i)
  status 201
rescue CancionNoEncontrada, UsuarioNoRegistrado => e
  status 404
  { error: e.message }.to_json
rescue CancionNoEscuchada => e
  status 409
  { error: e.message }.to_json
end

get '/megustas' do
  megustas = sistema.megustas
  respuesta = []
  megustas.map do |me_gustas|
    respuesta << { id_usuario: me_gustas.usuario.id, id_cancion: me_gustas.cancion.id }
  end
  status 200
  json(respuesta)
end

post '/podcasts' do
  @params.each do |podcast|
    sistema.crear_podcast(podcast[:titulo], podcast[:creador], podcast[:anio].to_i, podcast[:episodios])
  end
  status 201
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

  podcast = sistema.obtener_contenido_por_id(id_podcast)
  episodio = sistema.obtener_contenido_por_id(id_episodio)

  episodio.pertenece_a_podcast(podcast) # TODO: logica de negocio, sacar del controlador
  sistema.registrar_reproduccion(@params[:email], episodio)

  status 201
rescue UsuarioNoRegistrado, ContenidoNoEncontrado, EpisodioNoPerteneceAPodcast => e
  status 404
  { error: e.message }.to_json
end
