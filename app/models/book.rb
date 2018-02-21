class Book < ApplicationRecord
  belongs_to :person
  belongs_to :category
  belongs_to :address
  

  def self.search(search,author_search,category)
    if search || author_search ||category
      self.where("book_name like ? and author_name like ? and category_id=#{category}", "%#{search}%", "%#{author_search}%")  
    else
      self.all
    end
  end

  


end
