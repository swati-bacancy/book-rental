class AddColumnToBook < ActiveRecord::Migration[5.1]
  def up
     add_reference :books, :address, foreign_key: true
  end
  def down
    remove_reference :books, :address, foreign_key: true
  end
end
