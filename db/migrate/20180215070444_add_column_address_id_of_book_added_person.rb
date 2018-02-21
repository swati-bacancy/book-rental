class AddColumnAddressIdOfBookAddedPerson < ActiveRecord::Migration[5.1]
  def up
    add_column :addresses, :AddressIdOfBookAddedPerson, :integer 
  end
  def down
    remove_column :orders, :AddressIdOfBookAddedPerson, :integer
  end
end
