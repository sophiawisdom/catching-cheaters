class ProductController < ApplicationController
  def index
    @products = Product.all
    render :index
  end

  def show
    render :show
  end
end
