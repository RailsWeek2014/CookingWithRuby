module RecipesHelper
  def back_to_list
    content_tag :p do
      link_to t("Back"), recipes_path
    end
  end
end
