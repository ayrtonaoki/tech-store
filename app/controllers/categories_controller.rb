class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    category_name = Category.find(params[:id]).name
    @products = Product.where("category_id": params[:id])
    if @products.exists?
      flash[:notice] = "Showing all products from #{category_name} category"
    else
      flash[:notice] = "No product found in #{category_name} category"
      redirect_to categories_path
    end
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    values = params.require(:category).permit(:name)
    @category = Category.new(values)
    if @category.save
      flash[:notice] = "#{@category.name} was created"
      redirect_to categories_path
    else
      render :new
    end
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    redirect_to categories_path
  end

  def destroy
    category = Category.find(params[:id])
    product = Product.where("category_id": params[:id])
    if product.exists?
      flash[:alert] = "Can't delete: there is a product in this category"
      redirect_to categories_path
    else
      Category.destroy(params[:id])
      flash[:notice] = "#{category.name} was deleted"
      redirect_to categories_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end
