class UnitsController < ApplicationController
  def new
    unless current_user
      redirect_to new_user_session_path
    end
    @unit = Unit.new
  end
    
  def create
    @unit = Unit.new unit_params
    
    if @unit.save
      redirect_to recipes_path
    else
      render action: 'new'
    end
  end
  
  private
    def  unit_params
      params.require( 'unit' ).permit( 'long_name', 'name', 'conversion_factor', 'conversion_unit_id')
    end
end