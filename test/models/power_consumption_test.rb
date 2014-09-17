require 'test_helper'

class PowerConsumptionTest < ActiveSupport::TestCase
  def setup
    fake_devices_server_call
  end

  test "Calculates power correctly" do
    current_time = Time.current
    device       = FactoryGirl.create(:device,            { wattage: 60 })
    power        = FactoryGirl.create(:power_consumption, { device: device, created_at: (current_time - 30.minutes)})

    Timecop.freeze(current_time) do 
      power.update_power_consumption
    end

    assert_equal (PowerConsumption::POWER_COST * 60.fdiv(1000) * 0.5 ).round(5), power.cost.to_f
    assert_equal (0.5*60.fdiv(1000)).round(5), power.power_consumed.to_f
  end
end
