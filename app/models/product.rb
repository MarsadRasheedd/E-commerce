# frozen_string_literal: true

# product model conataing data about Products
class Product < ApplicationRecord
  include PgSearch::Model

  validates :title, :description, presence: { message: 'Cannot be blank.' },
                                  length: { minimum: 5, message: 'is too short.' }
  validates :price, numericality: { greater_than: 10 }
  validates :images, presence: { message: '(atleast one) must be provided.' }

  has_many_attached :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_and_belongs_to_many :users, dependent: :destroy
  accepts_nested_attributes_for :comments

  pg_search_scope :search, against: [:title],
                           using: {
                             tsearch: {
                               prefix: true
                             }
                           }

  def self.generate_serial_number
    random_array = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
    (0...10).map { random_array[rand(random_array.length)] }.join
  end
end
