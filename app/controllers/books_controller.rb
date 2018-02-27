class BooksController < ApplicationController
  before_action :authenticate_person!
  layout "devicelayout"
  def new
    @book=Book.new
    @addresses=Address.where(person_id:current_person.id)
  end
  def create
    @category=Category.find(params[:book][:category_id])
    @person=Person.find_by(params[:book][:person_id]) 
    @book=@category.books.create(book_params)
    @addresses=Address.where(person_id:current_person.id)
    @book.person_id=current_person.id
    if @book.save
      redirect_to books_viewallbooks_path
    else
      render 'new'
    end   
  end
  def viewallbooks
    @books=Book.where(person_id:current_person.id)
  end
  def show
    @book=Book.find(params[:id])
  end
  def index
    @books=Book.where(status: true)
    @first_book=@books.first.category_id
=begin
    if params[:category]==nil
      @cat=Category.find(@first_book)
    else
=end
    if params[:category]==nil
      @books=Book.where(status: true)
    else
      @cat=Category.find_by(category_name: params[:category]) 
      @books=@books.search(params[:search],params[:author_search],@cat.id)
    end
    #@books=Book.where(person_id:current_person.)
  end
  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to  books_viewallbooks_path 
  end
  def edit
    @book=Book.find(params[:id])
  end
  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      redirect_to books_path
    else
      render 'edit'
    end
  end
  def near_by_me
    @address_of_current_person=Address.where(person_id: current_person.id).last
    @books=Book.where(status: true)
    @bookadress=@books.pluck(:address_id)
    @arr=Array.new
    @bookadress.each do |address|
      @address=Address.find(address)
      @arr<<@address
    end

    @a=Array.new
    #@arr=@arr.uniq
    @arr.each do |i|
       b= @address_of_current_person.distance_to([i.latitude,i.longitude])  
       @a.push(b)
    end
    distance=Hash.new
    len=@arr.length
    len.times do |i|
      @add=@arr[i].id
      distance[@add] = @a[i]
    end
    distance=distance.sort {|a,b| a[1]<=>b[1]}
    @books_array=Array.new 
    distance.each do |i|
      @books_array.push(@books.where(address_id: i[0]))
    end
  
  

    #

  end



=begin
  def flatten_array(nested_array, initial=[])
    nested_array.each do |item|
      if item.kind_of?(Array)
        flatten_array(item, initial)
      else
        exit
        initial.push item

      end
    end
    initial
    exit
  end
=end

# Example of use
  private
  def book_params
    params.require(:book).permit(:book_name, 
                                :author_name, 
                                :book_price, 
                                :book_language, 
                                :book_publish_year,
                                :book_publisher_name,
                                :book_price_for_rent,
                                :duration_of_giving_book,
                                :person_id,
                                :category_id,
                                :address_id,
                                :search,
                                :author_search,
                                :bookImage)
  end
end
