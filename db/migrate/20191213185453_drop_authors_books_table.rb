class DropAuthorsBooksTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :authors_books
  end
end
