# frozen_string_literal: true

# this controller handles comments methods.
class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  def index
    @comments = Comment.all
  end

  def show
    authorize @comment
  end

  def new
    @comment = Comment.new
    authorize @comment
  end

  def edit
    authorize @comment
  end

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.create(comment_params)

    respond_to do |format|
      if @comment.save
        format.js { render nothing: true }
      else
        flash[:notice] = 'Something went wrong.'
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @comment
    if @comment.update(comment_params)
      flash[:notice] = 'Comment was updated sucessfully..'
    else
      flash[:alert] = 'Something went wrong.'
    end
    redirect_to product_path(@product)
  end

  def destroy
    authorize @comment
    if @comment.destroy
      flash[:notice] = 'Comment was successfully destroyed.'
    else
      flash[:alert] = 'Something went wrong!!'
    end
    redirect_to product_path(@product)
  end

  private

  def set_comment
    @product = Product.find(params[:product_id])
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:comment, :user_id)
  end
end
