class Room
  attr_accessor :available, :room_number, :price

  def initialize number, price
    @available = true
    @room_number = number
    @price = price
  end

  def check_in customer
    if is_available?
      @customer = customer
      @available = false
      customer.rooms << self
      p "Check-in successfull for Room: #{self.room_number}"
    else
      p "Room is not available"
    end
  end

  def check_out customer
    if @customer == customer
      @available = true
      @customer = nil
      p "Room : #{self.room_number} -  checked out"
    else
      p "Can't checkout "
    end
  end

  def is_available?
    @available
  end
end

class Deluxe < Room
end

class NonDeluxeAc < Room
end

class NonDeluxeNonAc < Room
end
