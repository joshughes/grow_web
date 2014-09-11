# This file is used by Rack-based servers to start the application.
require 'resque/server'

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application

map '/resque' do
   run Resque::Server.new
end
