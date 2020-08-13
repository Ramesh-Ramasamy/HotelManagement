class Address
  attr_accessor :address1, :city, :state, :country, :zipcode
  def initialize address1, city, state, country, zipcode
    @address1 = address1
    @city = city
    @state = state
    @country = country
    @zipcode = zipcode
  end
end