require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
 
  def setup
    fake_devices_server_call
  end

  should validate_presence_of :name
  should validate_presence_of :address
  should validate_uniqueness_of :address
  should validate_presence_of :digital
  should validate_presence_of :wattage

  def server_json_object(device)
    JSON.parse(device.server_json)
  end

  test "id is set by server" do
    count = Device.count
    device = FactoryGirl.create(:device)
    assert_equal count + 1, device.id
  end

  test "create power consumption entry" do
    device = FactoryGirl.create(:device, {state: true})
    assert_equal PowerConsumption.last.device.id, device.id
  end

  test "update power consumption when state changes" do
    device = {}
    Timecop.freeze(Time.current - 2.day ) do
      device = FactoryGirl.create(:device, {state: true})
    end
    stub_request(:put, "http://arm:8080/devices/#{device.id}.json")
    device.update_attribute(:state, false)
    refute_nil PowerConsumption.last.cost 
    refute_nil PowerConsumption.last.power_consumed
  end

  test "power consumption is not updated if state remains false" do
    initial_count = PowerConsumption.all.count 
    device = FactoryGirl.create(:device, {state: false, wattage: 1})
    stub_request(:put, "http://arm:8080/devices/#{device.id}.json")
    device.update_attributes({state: false, wattage: 10})
    device.reload
    assert_equal 10, device.wattage
    assert_equal initial_count, PowerConsumption.all.count 
  end

  test "update is sent to server" do 
    device = FactoryGirl.create(:device)
    stub_request(:put, "http://arm:8080/devices/#{device.id}.json")

    device.update(name: "foo")

    assert_requested :put, "http://arm:8080/devices/#{device.id}.json",
     :body => device.server_json , :times => 1 
  end

  test "server json" do
    device = FactoryGirl.build(:device, { digital: true })
    assert_equal 1,              server_json_object(device)["state"]
    assert_equal device.name,    server_json_object(device)["name"]
    assert_equal device.address, server_json_object(device)["address"]
    assert_equal 'D',            server_json_object(device)["type"]

    device.state = false
    assert_equal 0, server_json_object(device)["state"]
  end


end