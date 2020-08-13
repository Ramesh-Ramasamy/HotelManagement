load 'room.rb'
load 'customer.rb'
load 'address.rb'
class Hotel
  attr_accessor :name, :id, :customer, :deluxe_rooms, :non_deluxe_ac_rooms, :non_deluxe_non_ac_rooms

  def initialize(name,deluxe_room_count, non_deluxe_ac_room_count, non_deluxe_non_ac_room_count)
    @name = name
    @room_number = 0
    @deluxe_rooms = room_factory "Deluxe", deluxe_room_count, 3000
    @non_deluxe_ac_rooms = room_factory "NonDeluxeAc", non_deluxe_ac_room_count, 2000
    @non_deluxe_non_ac_rooms = room_factory "NonDeluxeNonAc", non_deluxe_non_ac_room_count, 1000 
    @customer = []
  end

  def room_factory type, count, price
    count.times.map do |i|
      @room_number += 1
      Object.const_get(type).new(@room_number, price)
    end
  end

  def available_rooms type = nil
    room_types = {"Deluxe" => self.deluxe_rooms, "NonDeluxeAc" => self.non_deluxe_ac_rooms, "NonDeluxeNonAc" => self.non_deluxe_non_ac_rooms}
    room_types = { type => room_types[type]} if room_types.keys.include?(type)
    available_rooms_with_type = {}
    room_types.each do |type, rooms|
      available_rooms_with_type[type] = rooms.map {|r| r if r.is_available?}.compact
    end
    available_rooms_with_type
  end

  def list_available_room
    p "Available Rooms:"
    available_rooms.each do |room_type, rooms|
      p "#{room_type} = #{rooms.length}"
    end
    p
  end

  def get_available_room type
    rooms = available_rooms type
    rooms[type][0] if rooms[type]
  end

  def add_customer name, id_proof, phone_number, address1, city, state, country, zipcode
    customer = Customer.new(name, id_proof, phone_number, address1, city, state, country, zipcode)
    @customer << customer
  end

  def check_in customer, roomtype
    room = get_available_room roomtype
    if room
      room.check_in customer
    else
      p " No #{roomtype} rooms are available "
    end
  end

  def check_out customer
    p "Customer Rooms:"
    customer.rooms.each_with_index do |room, i|
      p "#{i+1}. #{room.class.name} - #{room.room_number} "
    end
    p "Room to checkout:"
    room_number = gets.chomp.to_i
    if room_number > 0 && room_number <= customer.rooms.length
      customer.rooms[room_number-1].check_out
      customer.rooms.delete_at(room_number-1)
    else
      p "Invalid input"
    end
    p "Customer rooms count: #{customer.rooms.length}"
  end

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
hotel.list_available_room
hotel.add_customer("Ramesh", "121212", 9876543211, "23, Third cross", "Bangalore", "Karnataka", "India", "569004")
customer = hotel.customer[0]
hotel.check_in customer, "Deluxe"
hotel.find_customer "121212"
hotel.check_out customer
customer.city="Bangalore"
customer.state="KN"
p(customer.customer_details)
