class DevicesController < ApplicationController
  respond_to :html, :json
  def new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def toggle
    puts params.to_s
    device = Device.find(params[:device_id])
    if device.state == 1
      device.state = 0
    else
      device.state = 1
    end
    device.save
    redirect_to action: 'index'
  end

  def index
    @devices = Device.all
    respond_with(@devices)
  end

  def show
  end
end
