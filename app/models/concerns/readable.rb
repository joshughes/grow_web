module Readable
  extend ActiveSupport::Concern

  included do 
    after_commit :run_triggers
  end

  def run_triggers
    Resque.enqueue(EnqueTriggers, self.class.name, self.send(self.class.reading_method))
  end

  module ClassMethods
    def reading_method
      name.tap{|s| s.slice!("Reading")}.downcase
    end

    def chart_data
      reading_hash = {}
      all.each do | reading |
        reading_hash["#{reading.created_at}"] = reading.send(reading_method)
      end
      reading_hash
    end
  end

end

