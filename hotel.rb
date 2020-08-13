class Hotel
  attr_accessor :name, :id 

  include InstanceMethods
  extend ClassMethods

  def initialize(deluxe_room_count, non_deluxe_ac_room_count, non_deluxe_non_ac_room_count)
    @room_number = 0
    @deluxe_rooms = Hotel.room_factory "Deluxe", 10, 3000
    @non_deluxe_ac_rooms = Hotel.room_factory "NonDeluxeAc", 10, 2000
    @non_deluxe_non_ac_rooms = Hotel.room_factory "NonDeluxeNonAc", 10, 1000 
  end


  module ClassMethods
    def room_factory type, count, price
      count.times.map do |i|
        @room_number += 1
        type.constantize.create!(@room_number, price)
      end
    end
  end

  module InstanceMethods
    def available_rooms type = nil
      if not type

      else
        
      end
    end

    def checkin customer, roomtype
      
    end

  end

end