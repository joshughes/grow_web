require 'test_helper'

class TriggerTest < ActiveSupport::TestCase
  def setup
    fake_devices_server_call
  end
  test "the truth" do
    device  = FactoryGirl.create(:device,  {state: false})
    stub_request(:put, "http://arm:8080/devices/#{device.id}.json")
    trigger = FactoryGirl.create(:trigger, { device: device, state: true, value: 10, condition: '<' } )
    trigger.run(9)
    assert device.state
  end
end
