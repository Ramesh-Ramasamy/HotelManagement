require 'forwardable'
class Customer
  extend Forwardable
  attr_accessor :name, :id_proof, :phone_number, :address, :rooms
  def_delegators :@address, :address1=, :city=, :state=, :country=, :zipcode=

  def initialize name, id_proof, phone_number, address1, city, state, country, zipcode
    @name = name
    @id_proof = id_proof
    @phone_number = phone_number
    @address = Address.new(address1, city, state, country, zipcode)
    @rooms = []
  end

  def customer_details
    p "Name: #{self.name} (#{self.id_proof})"
    p "Mobile: #{self.phone_number}"
    p "Address: #{self.address.address1},#{self.address.city}, #{self.address.state},#{self.address.country} - #{self.address.zipcode}"
    p
  end

end