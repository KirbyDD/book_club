class Author < ApplicationRecord
  validates_presence_of :name

  has_many :authors_books
end
