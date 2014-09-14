class Trigger < ActiveRecord::Base
  belongs_to :device 

  CONDITIONS = %w{ > >= == < <= }

  validates_presence_of :device, :reading_type, :value
  validates :state, inclusion: [true, false]
  validates :condition, presence: true, inclusion: CONDITIONS

  def condition_valid?
    CONDITIONS.include? condition
  end

  def run(reading)
    device.update(state: state) if compare(reading)
  end

  private 

  def compare(reading)
    case condition 
    when ">"
      reading > value 
    when ">=" 
      reading >= value
    when "==" 
      reading == value
    when "<"
      reading < value
    when "<="
      reading <= value
    end
  end

end
