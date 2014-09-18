class PowerConsumption < ActiveRecord::Base
  POWER_COST = 0.46
  belongs_to :device

  validates :power_consumed, numericality: { greater_than: 0 }, presence: true, on: :update
  validates :cost,           numericality: { greater_than: 0 }, presence: true, on: :update
  
  def update_power_consumption
    power_consumed = (Time.current - created_at).fdiv(3600) * device.wattage.fdiv(1000)
    cost = (power_consumed * POWER_COST).round(5)
    if update(cost: cost, power_consumed: power_consumed)
      true
    else
      raise StandardError.new("#{self.errors.full_messages.to_sentence}")
    end
  end

end
