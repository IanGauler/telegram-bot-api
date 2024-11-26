class ConectorSpotify
  def initialize(api_url = ENV['SPOTIFY_API_URL'], client_id = ENV['SPOTIFY_CLIENT_ID'], client_secret = ENV['SPOTIFY_CLIENT_SECRET'])
    @client_id = client_id
    @client_secret = client_secret
    @api_url = api_url
    @api_token = nil
  end
end
