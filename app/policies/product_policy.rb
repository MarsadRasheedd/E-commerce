# frozen_string_literal: true

# Policy defined for products
class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  attr_reader :user, :product

  def initialize(user, product)
    super
    @user = user
    @product = product
  end

  def new?
    user&.seller?
  end

  def index?
    user
  end

  def create?
    user&.seller?
  end

  def edit?
    user&.products&.exists?(product.id)
  end

  def update?
    user&.products&.exists?(product.id)
  end

  def destroy?
    user&.products&.exists?(product.id)
  end
end
