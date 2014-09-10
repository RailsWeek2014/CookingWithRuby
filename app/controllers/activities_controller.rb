class ActivitiesController < ApplicationController
  def new
  end

  def create
    if @activity.save
      redirect_to activity_plans_overview_path
    else
      render action: 'new'
    end
  end
  
  private
    def activity_params
      params.require('activity').permit(:name, :kj)
    end
end
