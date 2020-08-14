# Address belongs to a Customer
class Address 
  #Using attr_accessor for getter setter
  attr_accessor :address1, :city, :state, :country, :zipcode
  
  #Constructor
  def initialize address1, city, state, country, zipcode
    @address1 = address1
    @city = city
    @state = state
    @country = country
    @zipcode = zipcode
  end
end