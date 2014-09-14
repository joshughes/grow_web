class TriggersController < ApplicationController
  include DeviceState

  before_filter :fix_state, :only => [:create, :update]
  respond_to :html, :json

  def new
    @trigger = Trigger.new
  end

  def create
    @trigger = Trigger.new(trigger_params)
    if @trigger.save
      redirect_to @trigger
    else
      render "new"
    end
  end

  def update
    @trigger = Trigger.find(params[:id])
    if @trigger.update(trigger_params)
      redirect_to @trigger
    else
      render 'edit'
    end
  end

  def edit
    @trigger = Trigger.find(params[:id])
  end

  def destroy
    @trigger = Trigger.find(params[:id])
    @trigger.delete
    render 'index'
  end

  def index
    @triggers = Trigger.all
    respond_with(@triggers)
  end

  def show
    @trigger = Trigger.find(params[:id])
  end

  private

    def trigger_params
      params.require(:trigger).permit(:condition, :state, :value, :reading_type, :device_id)
    end
end