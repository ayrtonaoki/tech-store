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
  end

  def create
    values = params.require(:category).permit(:name)
    @category = Category.new(values)
    if @category.save
      flash[:notice] = "#{@category.name} was created"
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Category.destroy(params[:id])
    redirect_to root_path
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
