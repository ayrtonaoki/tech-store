class ProductsController < ApplicationController
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
    values = params.require(:product).permit(:name, :description, :price, :amount, :category_id)
    @product = Product.new(values)
    if @product.save
      flash[:notice] = "#{@product.name} was created"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    id = params[:id]
    @product = Product.find(id)
    @categories = Category.all
    render :new
  end

  def update
    id = params[:id]
    @product = Product.find(id)

    values = params.require(:product).permit(:name, :description, :price, :amount, :category_id)
    if @product.update(values)
      flash[:notice] = "#{@product.name} was updated"
      redirect_to root_path
    else
      @categories = Category.all
      render :new
    end
  end

  def destroy
    Product.destroy(params[:id])
    redirect_to root_path
  end
end
