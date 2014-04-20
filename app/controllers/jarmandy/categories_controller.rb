class Jarmandy::CategoriesController < Jarmandy::BaseController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    respond_to do |f|
      f.html
      f.json { render json: @category.as_json(include: :challenges) }
    end
  end
end
