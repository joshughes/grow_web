module DeviceState
  extend ActiveSupport::Concern

  def fix_state
    device_state = params[controller_name.singularize.to_sym]["state"]
    if device_state == 'true'
      device_state = true
    else
      device_state = false
    end
    params[controller_name.singularize.to_sym]["state"] = device_state
  end
end