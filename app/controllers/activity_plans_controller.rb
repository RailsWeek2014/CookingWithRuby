class ActivityPlansController < ApplicationController
  def new
    if params[:date]
      @activity_plan.date = params[:date]
    end
  end

  def create
    if current_user.activity_plans << @activity_plan
      redirect_to activity_plans_overview_path
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @activity_plan.update_attributes(activity_plan_params)
      redirect_to activity_plans_path
    else
      render action: "edit"
    end
  end

  def destroy
    @activity_plan.destroy
    
    update_activity_plans_of_week
    
    7.times do |i|
      @days[i] = @days[i].to_a
    end
    
    render action: 'overview'
  end

  def overview
    update_activity_plans_of_week
    
    7.times do |i|
      @days[i] = @days[i].to_a
    end
  end
  
  private
    def update_activity_plans_of_week
      if params[:date]
        d = Date.parse(params[:date])
      else
        d = Date.today
      end
      
      @week_start = d.beginning_of_week
      @week_end = @week_start.end_of_week
      @activity_plans = current_user.activity_plans.where("date <= '#{ @week_end }' and date >= '#{ @week_start }'")
      @days = []
        
      d = @week_start
      
      7.times do |i|
        @days[i] = current_user.activity_plans.where( date: d.to_s )
        
        d = d.tomorrow
      end
    end
    
    def activity_plan_params
      params.require( 'activity_plan' ).permit(:activity_id, :date, :repetitions)
    end
end
