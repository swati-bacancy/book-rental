class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :book, foreign_key: true
      t.references :person, foreign_key: true
      t.references :address, foreign_key: true
      t.integer :order_status 
      t.timestamps
    end
  end
end
