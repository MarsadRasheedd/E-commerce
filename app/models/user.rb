# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :email, presence: true, length: { minimum: 4, message: 'is short.' }
  validates :address, presence: true, length: { minimum: 8, message: 'is too short.' }
  validates :phone, length: { minimum: 8, message: 'length must be greater then 8.' }
  validates_numericality_of :phone
  validates :encrypted_password, presence: { message: 'cannot be blank.' }

  belongs_to :cartt
  has_and_belongs_to_many :products
  has_many :comments, dependent: :destroy

  enum role: { visitor: 0, seller: 1, buyer: 2 }
end
