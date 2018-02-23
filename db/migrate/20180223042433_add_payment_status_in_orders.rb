class AddPaymentStatusInOrders < ActiveRecord::Migration[5.1]
  def up
    add_column :orders, :paymentStatus, :integer
  end
  def down
    remove_column :orders, :paymentStatus, :integer
  end
end
