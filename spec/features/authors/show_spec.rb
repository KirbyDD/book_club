require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "Should take me to show page" do
    author = Author.create!({name: "Tron"})
    author_two = Author.create!({name: "Kat"})
    book = author.books.create!({title: "Life of Tron", pages: 100, publication_year: "2014"})
    book_two = author.books.create!({title: "Battle of Kat", pages: 500, publication_year: "2009"})
    book_three = Book.create!({title: "Pulsars and Quasars", pages: 200, publication_year: "2018"})

    visit '/books'

    within("#book-#{book.id}") do
      click_link "#{author.name}"
    end

    expect(current_path).to eq("/authors/#{author.id}")
    expect(page).to have_content("#{author.name}")
    author.books.each do |book|
      expect(page).to have_content("#{book.title}")
    end
    expect(page).to have_content("300")

    expect(page).to_not have_content(author_two.name)
    expect(page).to_not have_content(book_three.title)
    expect(page).to_not have_content(book_three.pages)
    expect(page).to_not have_content(book_three.publication_year)
  end
end
