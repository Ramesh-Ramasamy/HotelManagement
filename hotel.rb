#load all the classes
load 'room.rb'
load 'customer.rb'
load 'address.rb'
class Hotel
  #Using attr_accessor for getter setter
  attr_accessor :name, :id, :customer, :deluxe_rooms, :non_deluxe_ac_rooms, :non_deluxe_non_ac_rooms

  #Constructor
  def initialize(name,deluxe_room_count, non_deluxe_ac_room_count, non_deluxe_non_ac_room_count)
    @name = name
    @room_number = 0
    # Build hotel with different type of rooms
    @deluxe_rooms = room_factory "Deluxe", deluxe_room_count, 3000
    @non_deluxe_ac_rooms = room_factory "NonDeluxeAc", non_deluxe_ac_room_count, 2000
    @non_deluxe_non_ac_rooms = room_factory "NonDeluxeNonAc", non_deluxe_non_ac_room_count, 1000 
    @customer = [] #Holds list of customers who have checked in atleast once
  end

  #Room factory for creating different type of rooms with count and price
  def room_factory type, count, price
    count.times.map do |i|
      @room_number += 1
      Object.const_get(type).new(@room_number, price) # Code reusability for creating different type of rooms
    end
  end

  # Gives the available rooms all or specific types
  def available_rooms type = nil
    room_types = {"Deluxe" => self.deluxe_rooms, "NonDeluxeAc" => self.non_deluxe_ac_rooms, "NonDeluxeNonAc" => self.non_deluxe_non_ac_rooms}
    room_types = { type => room_types[type]} if room_types.keys.include?(type)
    available_rooms_with_type = {}
    room_types.each do |type, rooms|
      available_rooms_with_type[type] = rooms.map {|r| r if r.is_available?}.compact
    end
    available_rooms_with_type
  end

  # Shows the list of available rooms for each type
  def list_available_rooms
    p "Available Rooms:"
    available_rooms.each do |room_type, rooms|
      p "#{room_type} = #{rooms.length}"
    end
    p
  end

  # Get a single available room for specific type
  def get_available_room type
    rooms = available_rooms type
    rooms[type][0] if rooms[type]
  end

  #Create and add new customer to the hotel
  def add_customer name, id_proof, phone_number, address1, city, state, country, zipcode
    customer = Customer.new(name, id_proof, phone_number, address1, city, state, country, zipcode)
    @customer << customer # Adding customer to customer list
  end

  #Checkin a particular room type
  def check_in customer, roomtype
    room = get_available_room roomtype #get available room
    if room # Checkin if any room available
      room.check_in customer
    else
      p " No #{roomtype} rooms are available "
    end
  end

  #Method to checkout rooms, Allows customer to check out only few rooms from his bookings
  def check_out customer
    p "Customer Rooms:"
    customer.rooms.each_with_index do |room, i|
      p "#{i+1}. #{room.class.name} - #{room.room_number} "
    end
    p "Room to checkout(Please enter any number from the above list):"
    room_number = gets.chomp.to_i
    if room_number > 0 && room_number <= customer.rooms.length
      customer.rooms[room_number-1].check_out
      customer.rooms.delete_at(room_number-1) #Delete room from his list
    else
      p "Invalid input"
    end
    p "Customer rooms count: #{customer.rooms.length}" #checking customer's room count after checkout
  end

  # find a customer with id_proof
  def find_customer id_proof
    customer = @customer.detect{|c| c.id_proof == id_proof} 
    if customer
      p "Name: #{customer.name}, Booked Rooms:#{customer.rooms.map(&:room_number).join(", ")}"
    else
      p "No Customer found"
    end
  end

end


hotel = Hotel.new("The RJ Inn",5,10,10)
p hotel.name
hotel.list_available_rooms
hotel.add_customer("Ramesh", "121212", 9876543211, "23, Third cross", "Bangalore", "Karnataka", "India", "569004")
customer = hotel.customer[0]
hotel.check_in customer, "Deluxe"
hotel.find_customer "121212"
hotel.check_out customer
customer.city="Bangalore"
customer.state="KN"
p(customer.customer_details)
