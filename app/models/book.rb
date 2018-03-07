class Book < ApplicationRecord
  belongs_to :person
  belongs_to :category
  belongs_to :address
  validates :book_name, :author_name, :book_price, :book_language, :book_publish_year, :book_publisher_name, :book_price_for_rent, :duration_of_giving_book, presence: true
  mount_uploader :bookImage, BookImageUploader
  def self.search(search,author_search,category="-1")
    if(category=="-1")
       self.where("book_name like ? and author_name like ?", "%#{search}%", "%#{author_search}%")
    else
      if search || author_search ||category
        self.where("book_name like ? and author_name like ? and category_id=#{category}", "%#{search}%", "%#{author_search}%")  
      else
        self.all
      end
    end
  end
end
