class Admin::CategoriesController < AdminController
  layout "admin"
  before_action :load_category, except: [:index, :new, :create]

  def destroy
    if @category.destroy
      flash[:success] = t "flash.deleted"
    else
      flash[:danger] = t "flash.delete_fail"
    end
    redirect_to admin_categories_path
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "flash.updated"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def index
    @categories = Category.ordered_by_name.paginate page: params[:page],
      per_page: Settings.categories_index.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "flash.created"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t "flash.nocategory"
    redirect_to admin_categories_path
  end
end
