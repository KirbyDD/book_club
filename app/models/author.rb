class Author < ApplicationRecord
  validates_presence_of :name

  has_many :authors_books
  has_many :books, through: :authors_books

  def avg_length
    total_pages = books.map do |book|
      book.pages
    end.sum
    total_pages / books.count
  end
end
