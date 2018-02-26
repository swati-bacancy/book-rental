class AddcolumnConfirmationCodeInOrder < ActiveRecord::Migration[5.1]
  def up
    add_column :orders, :confirmationCode, :string
  end
  def down
    remove_column :orders, :confirmationCode, :string
  end
end
