class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
     @product = Product.new
     @categories = Category.all
  end

  def create
    values = params.require(:product).permit(:name, :description, :price, :amount, :category_id)
    @product = Product.new(values)
    if @product.save
      flash[:notice] = "#{@product.name} was created"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    Product.destroy(params[:id])
    redirect_to root_path
  end

  def search
    @name = params[:name]
    @products = Product.where("name ilike ?", "%#{@name}%")
  end
end
