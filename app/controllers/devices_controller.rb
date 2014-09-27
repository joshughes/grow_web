class DevicesController < ApplicationController
  include DeviceState
  before_filter :fix_state, :only => [:create, :update]
  respond_to :html, :json
  def new
    @device = Device.new
  end

  def create
    @device = Device.new(device_params)
    if @device.save
      redirect_to @device
    else
      flash[:error] = @device.errors.full_messages.to_sentence
      render "new"
    end
  end

  def update
    @device = Device.find(params[:id])
    if @device.update(device_params)
      redirect_to @device
    else
      render 'edit'
    end
  end

  def edit
    @device = Device.find(params[:id])
  end

  def destroy
    Device.delete(params[:id])
    redirect_to action: 'index'
  end

  def toggle
    device = Device.find(params[:device_id])
    if device.state
      device.state = false
    else
      device.state = true
    end
    device.save
    redirect_to action: 'index'
  end

  def index
    @devices = Device.all
    respond_with(@devices)
  end

  def show
    @device = Device.find(params[:id])
  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def device_params
      params.require(:device).permit(:name, :address, :state, :wattage)
    end
end
