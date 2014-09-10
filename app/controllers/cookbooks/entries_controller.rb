class Cookbooks::EntriesController < ApplicationController
  skip_load_and_authorize_resource

  def new
    @cookbook_entry = CookbookEntry.new
    @recipe_id = params[:id]
    render layout: 'modal', locals: {headline: 'add_to_cookbook'}
  end
  
  def create
    @cookbook_entry = CookbookEntry.new cookbook_entry_params
    if @cookbook_entry.save
      render text: "ok"
    else
      render text: "nok"
    end
  end
  
  def destroy
    @cookbook_entry = CookbookEntry.find(params[:id])
    id = @cookbook_entry.cookbook.id
    @cookbook_entry.destroy
    redirect_to cookbook_path(id)
  end
  
  private
    def cookbook_entry_params
      params.require( 'cookbook_entry' ).permit('recipe_id', 'cookbook_id')
    end
end
