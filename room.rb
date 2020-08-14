# Room belongs to a Hotel
class Room
  #Using attr_accessor for getter setter
  attr_accessor :available, :room_number, :price, :customer
  
  #Constructor
  def initialize number, price
    @available = true
    @room_number = number
    @price = price
    @customer = nil # Room can be booked customer 
  end

  def check_in customer
    if is_available?
      self.customer = customer # Allocate this room for the customer
      self.available = false # make this room unavailable for others
      self.customer.rooms << self # include this room to the customer's room list
      p "Check-in successfull for Room: #{self.room_number}"
    else
      p "Room is not available"
    end
  end

  def check_out
    self.available = true # make room available
    self.customer = nil # Remove the associated customer
    p "Room : #{self.room_number} -  checked out"
  end

  def is_available?
    self.available #if available
  end
end


#Different types of rooms
class Deluxe < Room
  #If any specific functionality arrises for deluxe rooms, that can included or overide here
end

class NonDeluxeAc < Room
  #If any specific functionality arrises only for non deluxe ac rooms, that can included or overide here
end

class NonDeluxeNonAc < Room
  #If any specific functionality arrises only for non deluxe non ac rooms, that can included or overide here
end
