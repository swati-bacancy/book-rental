class PersonMailer < ApplicationMailer
  default from: 'swati.chauhan@bacancytechnology.com' 
  def confirm_order_email(person,code)
    @person=person
    @code= code
    mail to: [@person.email] , subject: 'confirmation of order'
  end
  def confirm_order_email_to_current_person(person,code)
    @person=person
    @code= code
    mail to: [@person.email] , subject: 'confirmation of order'
  end
end
