class CookbookEntriesController < ApplicationController
  
  def add_cookbook_entry
    @cookbook_entry = CookbookEntry.new cookbook_entry_params
    if @cookbook_entry.save
      render text: "ok"
    else
      render text: "nok"
    end
  end
  
  def add
    unless current_user
      redirect_to new_user_session_path
    end
    @cookbook_entry = CookbookEntry.new
    @recipe_id = params[:id]
    render layout: 'modal', locals: {headline: 'add_to_cookbook'}
  end
  
  private
    def cookbook_entry_params
      params.require( 'cookbook_entry' ).permit('recipe_id', 'cookbook_id')
    end
end
