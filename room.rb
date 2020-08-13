class Room
  attr_accessor :available, :room_number, :price, :customer

  def initialize number, price
    @available = true
    @room_number = number
    @price = price
    @customer = nil
  end

  def check_in customer
    if is_available?
      self.customer = customer
      self.available = false
      self.customer.rooms << self
      p "Check-in successfull for Room: #{self.room_number}"
    else
      p "Room is not available"
    end
  end

  def check_out
    self.available = true
    self.customer = nil
    p "Room : #{self.room_number} -  checked out"
  end

  def is_available?
    self.available
  end
end

class Deluxe < Room
end

class NonDeluxeAc < Room
end

class NonDeluxeNonAc < Room
end
