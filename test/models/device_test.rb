require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
 
  def setup
    fake_devices_server_call
  end

  should validate_presence_of :name
  should validate_presence_of :address
  should validate_uniqueness_of :address

  def server_json_object(device)
    JSON.parse(device.server_json)
  end

  test "id is set by server" do
    count = Device.count
    device = FactoryGirl.create(:device)
    assert_equal count + 1, device.id
  end

  test "update is sent to server" do 
    device = FactoryGirl.create(:device)
    stub_request(:put, "http://arm:8080/devices/#{device.id}.json")

    device.update(name: "foo")

    assert_requested :put, "http://arm:8080/devices/#{device.id}.json",
     :body => device.server_json , :times => 1 
  end

  test "server json" do
    device = FactoryGirl.build(:device)
    assert_equal 1,              server_json_object(device)["state"]
    assert_equal device.name,    server_json_object(device)["name"]
    assert_equal device.address, server_json_object(device)["address"]

    device.state = false
    assert_equal 0, server_json_object(device)["state"]
  end


end