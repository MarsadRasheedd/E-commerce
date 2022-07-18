# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :comment, presence: true

  belongs_to :product
  belongs_to :user
end
