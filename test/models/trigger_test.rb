require 'test_helper'

class TriggerTest < ActiveSupport::TestCase

  def setup
    fake_devices_server_call
  end

  test "test trigger triggers" do
    device  = FactoryGirl.create(:device,  {state: false})
    stub_request(:put, "http://arm:8080/devices/#{device.id}.json")
    trigger = FactoryGirl.create(:trigger, { device: device, state: true, value: 10, condition: '<' } )
    trigger.run(9)
    assert device.state
  end

  test "test trigger stays" do
    device  = FactoryGirl.create(:device,  {state: false})
    stub_request(:put, "http://arm:8080/devices/#{device.id}.json")
    trigger = FactoryGirl.create(:trigger, { device: device, state: true, value: 10, condition: '<' } )
    trigger.run(11)
    assert !device.state
  end

  test "test trigger runs on temperature reading" do
    device  = FactoryGirl.create(:device,  {state: false})
    stub_request(:put, "http://arm:8080/devices/#{device.id}.json")
    FactoryGirl.create(:trigger, { device: device, state: true, value: 10, condition: '<' } )
    FactoryGirl.create(:temperature_reading, { temperature: 9})
    device.reload
    assert device.state
  end


end
