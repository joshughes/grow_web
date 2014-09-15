class PowerConsumption < ActiveRecord::Base
  POWER_COST = 0.46
  belongs_to :device

  validates :power_consumed, numericality: { greater_than: 0 }, presence: true, on: :update
  validates :cost,           numericality: { greater_than: 0 }, presence: true, on: :update
  
  def update_power_consumption
    power_consumed = (Time.current - created_at)/3600 * 60 / 1000
    cost = power_consumed * POWER_COST
    update_attributes(cost: cost, power_consumed: power_consumed)
  end

end
