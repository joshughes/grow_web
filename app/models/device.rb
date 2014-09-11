
class Device < ActiveRecord::Base
  has_many :triggers

  validates :address, uniqueness: true, presence: true
  validates :name, presence: true
  validates :state, inclusion: [true, false]

  before_save :send_to_server

  def send_to_server 
    if self.new_record?
      create_on_server
    else
      update_on_server
    end
  end

  def create_on_server 
    if self.valid?
      conn = Faraday.new
      response = conn.post do |req|
        req.url 'http://arm:8080/devices.json'
        req.headers['Content-Type'] = 'application/json'
        req.body = server_json
      end
      json = JSON.parse(response.body)
      self.id = json["id"]
      response.success? 
    end
  end

  def update_on_server 
    if self.valid?
      conn = Faraday.new
      response = conn.put do |req|
        req.url "http://arm:8080/devices/#{id}.json"
        req.headers['Content-Type'] = 'application/json'
        req.body = server_json
      end
      response.success? 
    end
  end

  def server_json
    numeric_state = state ? 1:0
    json = { name: name, address: address, state: numeric_state }
    json.to_json
  end
end