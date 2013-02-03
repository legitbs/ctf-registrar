# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

use Rack::Auth::Basic, 'omg' do |username, password|
  logins = [
    ['ownOahibs', 'Neizgoav6'], # original
    ['legitbsness', 'frustration and alcoholism'], # new
    ['darktangent', 'rio promo code dirktangent'], # dt and judging
  ]

  logins.include? [username, password]
end
run CtfRegistrar::Application
