class Address < ApplicationRecord
  belongs_to :person
  has_one :order, dependent: :destroy
  has_one :book
  validates :full_name, :address_line1, :address_line2, :city, :state, :country, :pincode, presence: true
  #validates :pincode ,length: { is: 6 ,message: "must be given please"}
  validates_length_of :pincode, :maximum => 6, :minimum=>6, :message => "less than  if you don't mind"
=begin
  geocoded_by :address
  after_validation geocoded, :if=>lambda{ |obj| obj.address_line1.changed? && obj.address_line2.changed? && obj.city.changed? && obj.state.changed? &&obj.pincode.changed?  }
  def address
    [address_line1,address_line2,city,state,pincode].compact.join(', ')
  end
=end
  geocoded_by :address # address is an attribute of MyModel
  # or with a method
  geocoded_by :full_address # full_address is a method which take some model's attributes to get a formatted address for example
  # the callback to set longitude and latitude
  after_validation :geocode
  # the full_address method
  def full_address
    "#{address_line1}, #{address_line2}, #{city}, #{state},#{pincode}"
  end
end  
 