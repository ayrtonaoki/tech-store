class ProductsController < ApplicationController

  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def search
    @name = params[:name]
    @products = Product.where("name ilike ?", "%#{@name}%")
    if @products.exists?
      flash[:notice] = "Results for #{@name}"
    else
      flash[:error] = "No results for #{@name}"
    end
  end

  def new
     @product = Product.new
     @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "#{@product.name} was created"
      redirect_to root_path
    else
      render_view(:new)
    end
  end

  def edit
    render_view(:edit)
  end

  def update
    if @product.update(product_params)
      flash[:success] = "#{@product.name} was updated"
      redirect_to root_path
    else
      render_view(:new)
    end
  end

  def destroy
    @product.destroy
    flash[:success] = "#{@product.name} was deleted"
    redirect_to root_path
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :amount, :category_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def render_view(view)
    @categories = Category.all
    render view
  end
end
