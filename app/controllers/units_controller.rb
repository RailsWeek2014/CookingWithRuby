class UnitsController < ApplicationController
  def new
  end
    
  def create
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