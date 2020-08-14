require 'forwardable' # library for delagation
class Customer
  extend Forwardable # library for delagation
  #Using attr_accessor for getter setter
  attr_accessor :name, :id_proof, :phone_number, :address, :rooms
  # delegate to update associated address object value
  def_delegators :@address, :address1=, :city=, :state=, :country=, :zipcode=
  
  #Constructor
  def initialize name, id_proof, phone_number, address1, city, state, country, zipcode
    @name = name
    @id_proof = id_proof
    @phone_number = phone_number
    @address = Address.new(address1, city, state, country, zipcode) # Customer has one address
    @rooms = [] # Customer has many rooms
  end

  #Display customer details
  def customer_details
    p "Name: #{self.name} (#{self.id_proof})"
    p "Mobile: #{self.phone_number}"
    p "Address: #{self.address.address1},#{self.address.city}, #{self.address.state},#{self.address.country} - #{self.address.zipcode}"
    p
  end

end