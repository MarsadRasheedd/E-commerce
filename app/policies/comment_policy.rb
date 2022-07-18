# frozen_string_literal: true

# Policy defined for comments
class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  attr_reader :user, :comment

  def initialize(user, comment)
    super
    @user = user
    @comment = comment
  end

  def new?
    user
  end

  def create?
    user
  end

  def show?
    user&.comments&.exists?(comment.id)
  end

  def edit?
    user&.comments&.exists?(comment.id)
  end

  def destroy?
    user&.comments&.exists?(comment.id)
  end

  def update?
    user&.comments&.exists?(comment.id)
  end
end
