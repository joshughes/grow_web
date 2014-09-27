class SnapshotsController < ApplicationController
  def take_snapshot
    @snapshot = Snapshot.get_snapshot
    redirect_to @snapshot
  end

  def latest
    @snapshot = Snapshot.last
    render "show"
  end

  def show
    @snapshot = Snapshot.find(params[:id])
  end

end
