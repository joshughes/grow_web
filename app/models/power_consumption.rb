class PowerConsumption < ActiveRecord::Base
  belongs_to :device

  validates :power_consumed, numericality: { greater_than: 0 }, presence: true, on: :update
  validates :cost,           numericality: { greater_than: 0 }, presence: true, on: :update

  

end
