# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    ROLES=["admin","user"]
    ROLES.each do |role|
      Role.find_or_create_by(name: role)
    end
    admin= Person.find_by(email:"swati.chauhan@bacancytechnology.com")
    unless admin.present?
      admin = Person.create(user_name:"swati chauhan",email:"swati.chauhan@bacancytechnology.com",date_of_birth:"16/09/1997",gender:"female",contact_number:"1234567890")
      admin.password =  "123456"
      admin.save
      
      admin.save
    end
    admin.add_role "admin"

    puts admin.errors.full_messages