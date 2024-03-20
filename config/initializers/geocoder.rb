Geocoder.configure(
  units: :km,
  timeout: 15
)
  # Geocoding options
  # timeout: 3,                 # geocoding service timeout (secs)
  # lookup: :nominatim,         # name of geocoding service (symbol)
  # ip_lookup: :ipinfo_io,      # name of IP address geocoding service (symbol)
  # language: :en,              # ISO-639 language code
  # use_https: false,           # use HTTPS for lookup requests? (if supported)
  # http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
  # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
  # api_key: ENV['MAPBOX_API_KEY'], # API key for geocoding service
  # cache: nil,                 # cache object (must respond to #[], #[]=, and #del)

  # Exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and Timeout::Error
  # always_raise: [],

  # Calculation options
  # :km for kilometers or :mi for miles
  # distances: :linear          # :spherical or :linear

  # Cache configuration
  # cache_options: {
  #   expiration: 2.days,
  #   prefix: 'geocoder:'
  # }
# )

# Geocoder.configure(
#   # Specify Mapbox as the lookup service
#   lookup: :mapbox,
#   # Use HTTPS for requests
#   use_https: true,
#   # Your Mapbox API key from the .env file
#   api_key: ENV['MAPBOX_API_KEY'],
#   # Set units to kilometers or miles, according to your preference
#   units: :km,
#   # Optionally, specify cache to reduce the number of requests
#   # cache: Redis.new,
#   # Cache expiration time and prefix (if using cache)
#   # cache_options: { expiration: 2.days, prefix: 'geocoder:' }
# )
