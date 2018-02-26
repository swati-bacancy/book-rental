class Person < ApplicationRecord
  rolify  
  after_create :assign_default_role

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable 

  has_many :books
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
