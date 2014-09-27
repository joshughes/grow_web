class Snapshot < ActiveRecord::Base
  has_attached_file :shot

  validates_attachment_file_name :shot, :matches => [/jpe?g\Z/]
  
  def self.get_snapshot
    conn = Faraday.new
    response = conn.get do |req|
      req.url 'http://arm:8080/screenshot.json'
      req.headers['Content-Type'] = 'application/json'
    end
    json = JSON.parse(response.body)
    StringIO.open(Base64.decode64(json["image"])) do |data|
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = "room_shot_#{Time.now.utc.iso8601}.jpg"
      data.content_type = "image/jpeg"
      Snapshot.create(shot: data)
    end
  end
end
