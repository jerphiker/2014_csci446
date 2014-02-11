class StoreController < ApplicationController
  include CurrentCart
  def index
    @products = Product.order(:title)
  end
end
