class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def create
    product = params.require(:product).permit(:name, :description, :price, :amount)
    Product.create(product)
    redirect_to root_path
  end

  def destroy
    Product.destroy(params[:id])
    redirect_to root_path
  end
end
