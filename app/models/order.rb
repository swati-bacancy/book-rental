class Order < ApplicationRecord
  belongs_to :book
  belongs_to :person
  belongs_to :address
  enum order_status:[:placed,:confirmed]
end
