class ProductsController < ApplicationController

  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def search
    @name = params[:name]
    @products = Product.where("name ilike ?", "%#{@name}%")
  end

  def new
     @product = Product.new
     @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "#{@product.name} was created"
      redirect_to root_path
    else
      render_new_view
    end
  end

  def edit
    render_new_view
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "#{@product.name} was updated"
      redirect_to root_path
    else
      render_new_view
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :amount, :category_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def render_new_view
    @categories = Category.all
    render :new
  end
end
