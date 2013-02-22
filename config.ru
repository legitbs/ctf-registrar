# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

use Rack::Auth::Basic, 'omg' do |username, password|
  logins = [
    ['ownOahibs', 'Neizgoav6'], # original
    ['legitbsness', 'frustration and alcoholism'], # new
    ['darktangent', 'rio promo code dirktangent'], # dt and judging
    ['singularity', 'in this case it causes them'], # dustin 1
    ['snow crash', 'neal stephenson needs an editor'], # dustin 2
    ['jordan', 'hilarious georgia brown dot mp3'], # jordan w
    ['steve v', 'not the erlang steve v'], # steve v
  ]

  logins.include? [username, password]
end
run CtfRegistrar::Application
