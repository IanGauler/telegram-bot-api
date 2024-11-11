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
  set :sistema, Sistema.new(RepositorioUsuarios.new, RepositorioCanciones.new)
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
  sistema.eliminar_usuarios
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
  sistema.crear_cancion(@params[:titulo], @params[:artistas], @params[:anio], @params[:duracion])
  status 201
end

get '/canciones' do
  canciones = sistema.canciones
  respuesta = []
  canciones.map do |c|
    puts c.inspect
    respuesta << { titulo: c.titulo, artistas: c.artistas, anio: c.anio, duracion: c.duracion, id: c.id }
  end
  status 200
  json(respuesta)
end
