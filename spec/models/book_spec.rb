require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :pages}
    it {should validate_presence_of :publication_year}
  end

  describe 'relationships' do
    it {should have_many :authors_books}
    it {should have_many(:authors).through(:authors_books)}
  end

  describe 'methods' do
    it "should return average length '.avg_length'" do
      author = Author.create!({name: "Tron"})
      book = author.books.create!({title: "Life of Tron", pages: 100, publication_year: "2014"})
      book_two = author.books.create!({title: "Battle of Laniakea", pages: 200, publication_year: "2009"})

      expect(author.avg_length).to eq(150)
    end
  end
end
