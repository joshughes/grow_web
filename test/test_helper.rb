ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'

class ActiveSupport::TestCase

  self.use_transactional_fixtures = true

  def setup 
    Resque.inline = true
    WebMock.disable_net_connect!(:allow_localhost => true)
    #DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  def teardown 
    DatabaseCleaner.clean
  end

  
  def fake_devices_server_call
    server_id = Device.count + 1
    stub_request(:post, "http://arm:8080/devices.json").to_return(body: "{\"id\": #{server_id} }", status: 200 )
  end

end
