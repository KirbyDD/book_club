require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  it 'Should show all books' do
    author = Author.create!({name: "Tron"})
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
  end

  it 'Should not show authors that dont have books' do
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
        expect(page).to_not have_link(author_two.name)
      end
    end
  end

  it 'Should show multiple authors for books if they have them' do
    author = Author.create!({name: "Tron"})
    author_two = Author.create!({name: "Kat"})
    book = author.books.create!({title: "Life of Tron", pages: 100, publication_year: "2014"})
    book.authors << author_two

    visit '/books'

    within("#book-#{book.id}") do
      expect(page).to have_content(book.title)
      expect(page).to have_content(book.pages)
      expect(page).to have_content(book.publication_year)
      book.authors.each do |author|
        expect(page).to have_link(author.name || author_two.name)
      end
    end
  end
end
