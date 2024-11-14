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
  set :sistema, Sistema.new(RepositorioUsuarios.new, RepositorioCanciones.new, RepositorioReproducciones.new, RepositorioMegustas.new)
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
  usuario = sistema.crear_usuario(@params[:id].to_i, @params[:email])
  status 201
  { id: usuario.id, email: usuario.email }.to_json
rescue UsuarioYaRegistrado => e
  status 409
  { error: e.message }.to_json
end

post '/agregar_canciones' do
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
  canciones = sistema.obtener_novedades
  respuesta = []
  canciones.map do |c|
    respuesta << { titulo: c.titulo, artistas: c.artistas, anio: c.anio, duracion: c.duracion, id: c.id }
  end
  status 200
  json(respuesta)
end

get '/datos/:id' do
  cancion = sistema.obtener_datos_cancion_por_id(params[:id].to_i)
  respuesta = { titulo: cancion.titulo, artistas: cancion.artistas, anio: cancion.anio, duracion: cancion.duracion }
  status 200
  json(respuesta)
rescue CancionNoEncontrada => e
  status 404
  { error: e.message }.to_json
end

post '/reproduccion' do
  sistema.registrar_reproduccion(@params[:email], @params[:id_cancion].to_i)
  status 201
rescue UsuarioNoRegistrado, CancionNoEncontrada => e
  status 404
  { error: e.message }.to_json
end

get '/reproducciones' do
  reproducciones = sistema.reproducciones
  respuesta = []
  reproducciones.map do |r|
    respuesta << { id_usuario: r.id_usuario, id_cancion: r.id_cancion }
  end
  status 200
  json(respuesta)
end

post '/megusta' do
  sistema.registrar_megusta(@params[:id_usuario].to_i, @params[:id_cancion].to_i)
  status 201
rescue CancionNoEncontrada => e
  status 404
  { error: e.message }.to_json
rescue CancionNoEscuchada => e
  status 409
  { error: e.message }.to_json
end

get '/megustas' do
  megustas = sistema.megustas
  respuesta = []
  megustas.map do |m|
    respuesta << { id_usuario: m.id_usuario, id_cancion: m.id_cancion }
  end
  status 200
  json(respuesta)
end
