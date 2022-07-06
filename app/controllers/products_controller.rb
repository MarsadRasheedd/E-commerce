class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  def index
    if params[:search]
      @products = Product.search(params[:search]).with_pg_search_highlight
    else
      @products = Product.all
    end
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def search
    if params[:title_search].present?
      @products = Product.search(params[:search])
    end
    respond_to do |format|
      format.js
    end
    # respond_to do |format|
    #   format.turbo_stream do
    #     # render turbo_stream: turbo_stream.update("search_results", Time.zone.now)
    #     # render turbo_stream: turbo_stream.update("search_results", @movies.count)
    #     render turbo_stream: turbo_stream.update("search_results",
    #                             partial: "search_results", locals: { products: @products })
    #   end
    # end
  end

  def create
    @product = Product.new(product_params)
    @product.serial_no = Product.generate_serial_number

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :price, :serial_no, images: [])
    end
end
