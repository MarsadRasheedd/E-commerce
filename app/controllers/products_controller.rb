# frozen_string_literal: true

# this controller handles products methods.
class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authorize_product, only: %i[create]

  def index
    if current_user&.buyer?
      current_user.seller!
      flash[:notice] = 'Switched to seller'
      redirect_to :root
    end
    @products = current_user.products
    authorize @products
  end

  def show; end

  def new
    @product = Product.new
    authorize @product
  end

  def public_products
    @cart_item = CartItem.new
    @products = params[:search] ? Product.search(params[:search]) : Product.all
  end

  def error_page
    render file: 'public/404.html'
  end

  def edit
    authorize @product
  end

  def create
    respond_to do |format|
      if @product.save
        current_user.products << @product
        format.html { redirect_to product_url(@product), notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @product
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @product
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def authorize_product
    @product = Product.new(product_params)
    @product.serial_no = Product.generate_serial_number
    authorize @product
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :serial_no, images: [])
  end
end
