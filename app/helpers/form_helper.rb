module FormHelper
  def collection_select_with_input
    content_tag :p do
      link_to t("Back"), recipes_path
    end
  end
end
