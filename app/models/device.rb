require 'active_resource'  

class Device < ActiveResource::Base 
  self.site = "http://arm:8080/"
end