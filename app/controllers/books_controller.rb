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
    @book.person_id=current_person.id
    @book.save
    redirect_to books_viewallbooks_path   
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
    @bookadress=Book.where(status: true)
    @bookadress=@bookadress.pluck(:address_id)
    @arr=Array.new
    @bookadress.each do |address|
      @address=Address.find(address)
      @arr<<@address
    end
      
 








    @a=Array.new
    @arr=@arr.uniq
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

    distance_array=distance.values
    address_array=distance.keys

    if address_array.length==1

    else
=begin
address_array.each do |t|
      i=0
       address_array.each do |b|
         if b > address_array[i+1]
          address_array[i],address_array[i+1] = address_array[i+1],address_array[i]
          distance_array[i],distance_array[i+1] = distance_array[i+1],distance_array[i]
         end
         i+=1 if i < address_array.size-2
       end
      end
=end
=begin
        address_array.each do |t|
          address_array.each do |b|
            if (t > b) 
                a =  address_array[t];
                address_array[t] = address_array[b];
                address_array[b] = a;

                c =  distance_array[t];
                distance_array[t] = distance_array[b];
                distance_array[b] = c;
            end
          end
        end
=end
  address_array.each do |i|                    #Loop for ascending ordering
    address_array.each do |j|            #Loop for comparing other values
      if address_array[j] > address_array[i]                #Comparing other array elements
       tmp = address_array[i]       #Using temporary variable for storing last value
        address_array[i] = address_array[j]           #replacing value
        address_array[j] = tmp           #storing last value
      end
    end
  end



     end 


    @books=Array.new
    address_array.each do |i|
      @books<<Book.where(address_id:i)

    end

=begin

     @address=Array.new
    @address_of_current_person=Address.where(person_id: current_person.id).last
    @bookadress=Book.where(status: true)
    @bookadress.each do |book|
      @address[]=book.address
    end
    exit
  
=end


  end




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
                                :author_search)
  end
end
