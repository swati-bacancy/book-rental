k class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :book_name
      t.string :author_name
      t.decimal :book_price
      t.string :book_language
      t.date :book_publish_year
      t.string :book_publisher_name
      t.decimal :book_price_for_rent
      t.date :duration_of_giving_book
      t.belongs_to :person, foreign_key: true
      t.belongs_to :category, foreign_key: true
      t.timestamps
    end
  end
end
