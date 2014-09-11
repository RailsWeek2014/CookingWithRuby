class SearchController < ApplicationController
  skip_load_and_authorize_resource
  
  def search
    @recipes = Recipe.find_by_fuzzy_name(params[:keywords], limit: 20)
    @recipes |= Recipe.find_by_fuzzy_instructions(params[:keywords], limit: 20) 
    keywords = params[:keywords].split(" ")
    search_in_recipe(keywords)
    search_in_ingredient(keywords)
    respond_to do |format|      
      format.html {
        @headline = t('search.results_for', search: params[:keywords])
        render 'recipes/list'
      }
      format.js {
        @recipes = @recipes.to_json.html_safe
      }
    end
  end

  def advanced_search
  end

  
  private
    def search_in_recipe keywords
      recipes = Recipe.arel_table
      where = nil
      keywords.each { |keyword|
        if(keyword.length > 3)
          query = "%#{keyword}%"
          if(where.nil?)
            where = recipes[:name].matches(query)\
              .or(recipes[:instructions]).matches(query)
          else
            where = where.or(recipes[:name].matches(query)\
              .or(recipes[:instructions]).matches(query))
          end
        end
      }
      @recipes |= Recipe.where(where)
    end


    def search_in_ingredient keywords
      ingredients = Ingredient.arel_table
      where = nil
      keywords.each { |keyword|
        if(keyword.length > 3)
          query = "%#{keyword}%"
          if(where.nil?)
            where = ingredients[:name].matches(query)
          else
            where = where.or(ingredients[:name].matches(query))
          end
        end
      }
      recipes = Recipe.all
      
      ingredients = Ingredient.where(where) 
        ingredients.each do |i|
        recipes &= i.recipes
      end
      @recipes |= recipes
    end
end
