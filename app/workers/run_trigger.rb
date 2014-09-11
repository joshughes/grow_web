class RunTrigger
  @queue = :run_triggers

  def self.perform(trigger_id, sensor_reading)
    trigger = Trigger.find(trigger_id)
    trigger.run(sensor_reading)
  end
end