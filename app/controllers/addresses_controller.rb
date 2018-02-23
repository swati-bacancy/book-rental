class AddressesController < ApplicationController
  layout "devicelayout"
  def new 
    @address=Address.new
  end

  def create
    @address=Address.new(address_params)
    @address.person_id= current_person.id
    if @address.save
      redirect_to addresses_path
    else
      render 'new'
    end  
  end

  def index
    @addresses=Address.where(person_id:current_person.id)
  end

  def addnew
    @address=Address.new

  end

  def viewaddress
    @addresses=Address.where(person_id:current_person.id)
    @book=Book.find(params[:id])
  end

  def show
    @address=Address.find(params[:id])
  end

  def edit
    @address=Address.find(params[:id])  
  end

  def update
    @address=Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render 'edit'
    end
  end

  def destroy
    @address=Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path 
  end

  def confirm_order
    @address=Address.find(params[:address_id])
    @book=Book.find(params[:book_id])
    @sellerDetail=@book.person
    @sellerAddressDetail=@book.address
  end

  def change_city
    params[:state]
    @state = CS.states(:in).key(params[:state])
  end

  private
  def address_params
    params.require(:address).permit(:full_name,
                                    :address_line1, 
                                    :address_line2, 
                                    :city, 
                                    :state, 
                                    :country, 
                                    :pincode, 
                                    :person_id)
  end
end
