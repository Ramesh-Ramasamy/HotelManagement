class Customer
  attr_accessor :name, :id_proof, :phone_number, :address, :rooms
  def initialize name, id_proof, phone_number, address1, city, state, country, zipcode
    @name = name
    @id_proof = id_proof
    @phone_number = phone_number
    @address = Address.new(address1, city, state, country, zipcode)
    @rooms = []
  end
end