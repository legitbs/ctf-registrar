class Jarmandy::CategoriesController < Jarmandy::BaseController
  def index
    @categories = Category.all.order(order: :asc)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "category #{@category.name} created"
      return redirect_to jarmandy_categories_path
    end

    render action: 'new'
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]

    if @category.update_attributes category_params
      flash[:success] = "updated #{@category.name}"
      return redirect_to jarmandy_categories_path
    end

    render action: 'edit'
  end

  def show
    @category = Category.find(params[:id])
    respond_to do |f|
      f.html
      f.json { render json: @category.as_json(include: :challenges) }
    end
  end

  private
  def category_params
    params.require(:category).permit %i(name order description)
  end
end
