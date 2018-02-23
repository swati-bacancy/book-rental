  class OrdersController < ApplicationController
    layout "devicelayout"
  def new
    @order=Order.create
  end
  def create
    @book=Book.find(params[:order][:book_id])
    @address=Address.find(order_params[:address_id])
    @order = Order.new(order_params)
    @order.person_id=current_person.id
    @order.order_status=0  
    @order.paymentStatus=0   
    # @order=@book.create_order(order_params)
    @order.save
    @book.status=false
    @book.save

    redirect_to books_path
  end 

  def index
    @orders=Order.where(person_id: current_person.id)
    @count=@orders.count

  end
  def show
    @book=Book.find(params[:id])
    @order=Order.find_by(book_id: @book.id)
  end
  def destroy
    @order=Order.find(params[:id])
    @book=@order.book
    @book.status=true
    @book.save
    @order.destroy
    redirect_to orders_path
  end


  def order_detail
    @address=Address.find(params[:address_id])
    @book=Book.find(params[:id])
    @address=Address.find(order_params[:address_id])
  end

  def confirm_order
    @book=Book.find(order_params[:book_id])
  end

  def final_confirm
    @order=Order.find(params[:id])
    @order.order_status=1
    @code=SecureRandom.hex(10)
    @order.confirmationCode=@code
    @order.save
    PersonMailer.confirm_order_email(@order.person,@code).deliver_now
    PersonMailer.confirm_order_email(current_person,@code).deliver_now
    redirect_to  books_viewallbooks_path 
  end


  private
  def order_params
    params.require(:order).permit(:person_id,:book_id,:address_id)
  end
end
