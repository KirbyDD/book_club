class Book < ApplicationRecord
  validates_presence_of :title, :pages, :publication_year

  has_many :authors_books
  has_many :authors, through: :authors_books
end
