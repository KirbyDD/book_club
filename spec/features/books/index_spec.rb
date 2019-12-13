require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  it 'Should show all books' do
    author = Author.create!({name: "Tron"})
    author_two = Author.create!({name: "Kat"})
    book = author.books.create!({title: "Life of Tron", pages: 100, publication_year: "2014"})

    visit '/books'

    within("#book-#{book.id}") do
      expect(page).to have_content(book.title)
      expect(page).to have_content(book.pages)
      expect(page).to have_content(book.publication_year)
      book.authors.each do |author|
        expect(page).to have_link(author.name)
      end
    end

    expect(page).to_not have_content("Battle of Kat")
    expect(page).to_not have_content("500")
    expect(page).to_not have_content("2009")
    expect(page).to_not have_link(author_two.name)

    book_two = author.books.create!({title: "Battle of Kat", pages: 500, publication_year: "2009"})
    book_two.authors << author_two

    visit '/books'

    within("#book-#{book.id}") do
      expect(page).to have_content(book.title)
      expect(page).to have_content(book.pages)
      expect(page).to have_content(book.publication_year)
      book.authors.each do |author|
        expect(page).to have_link(author.name)
      end
    end

    within("#book-#{book_two.id}") do
      expect(page).to have_content(book_two.title)
      expect(page).to have_content(book_two.pages)
      expect(page).to have_content(book_two.publication_year)
      book_two.authors.each do |author|
        expect(page).to have_link(author.name)
      end
    end
  end
end
