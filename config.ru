# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

use Rack::Auth::Basic, 'omg' do |username, password|
  [username, password] == ['ownOahibs', 'Neizgoav6']
end
run CtfRegistrar::Application
