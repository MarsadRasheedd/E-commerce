class Product < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, :against => [:title],
    using: {
      tsearch: {
        prefix: true,
        highlight: {
          start_sel: '<b>',
          stop_sel: '</b>',
        }
      }
    }

  has_many_attached :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :cart_items,  dependent: :destroy
  has_and_belongs_to_many :users

  def self.generate_serial_number
    random_array = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
    serial_no = (0...10).map { random_array[rand(random_array.length)] }.join
  end
end
