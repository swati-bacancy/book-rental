class AddColumnStatusInBook < ActiveRecord::Migration[5.1]
  def up
    add_column :books, :status, :boolean, default: :true
  end 
  def dowm
   remove_column :books, :status, :boolean
  end
end
