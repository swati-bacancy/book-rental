class AddColumnBookImageInBook < ActiveRecord::Migration[5.1]
  def up
    add_column :books, :bookImage, :string
  end
  def down
    remove_column :books, :bookImage, :string
  end
end
