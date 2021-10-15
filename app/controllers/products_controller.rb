class ProductsController < ApplicationController
  before_action :authorize_request
  before_action :load_product, except: [:index, :create]

  def index
    @products = Product.all
    render json: @products, status: :ok
  end

  def show
    render json: @product, status: :ok
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    render json: {message: "Product successfully deleted"}, status: :ok if @product.destroy
  end

  private

  def load_product
    @product = Product.find_by_id(params[:id])
    if @product.nil?
      render json: { message: 'Product does not exist' }, status: :not_found
      end
  end

  def product_params
    params.permit(:product_name, :product_number, :manufature_date, :price, :quantity, :variant, :description)
  end
end
