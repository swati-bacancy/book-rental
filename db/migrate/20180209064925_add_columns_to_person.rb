class AddColumnsToPerson < ActiveRecord::Migration[5.1]
    def up
    add_column :people, :user_name, :string
    add_column :people, :date_of_birth, :date
    add_column :people, :gender, :string
    add_column :people, :contact_number, :string
  end

  def down
    remove_column :people, :user_name, :string
    remove_column :people, :date_of_birth, :date
    remove_column :people, :gender, :string
    remove_column :people, :contact_number, :string
  end
end
