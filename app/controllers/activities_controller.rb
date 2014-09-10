class ActivitiesController < ApplicationController
  def new
  end

  def create
    if @activity.save
      render text: 'OK'
    else
      render action: 'new'
    end
  end
  
  private
    def activity_params
      params.require('activity').permit(:name, :kj)
    end
end
