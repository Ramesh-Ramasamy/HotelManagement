## HotelManagement
>	There are different types of rooms with different pricing allowing 2 person per room

### This is a ruby application with following features:
*	Listing available rooms
*	There are different types of rooms with different pricing
*	Check-in into a room
*	Check-out of a room
*	Add Customer
*	Find customer
*	Update customer details (different attributes)

### Associations:
* 	Hotel has many Rooms and many Customers
*	Room belongs to a Hotel and booked by a Customer
*	Customer can book many Rooms
*	Customer has one address
*   Address belongs to a Customer

### Use below ruby commands to check the functionality
```ruby
load 'hotel.rb' # load hotel.rb
hotel = Hotel.new("The RJ Inn",5,10,10) # creating new hotel
p hotel.name # print hotel name
hotel.list_available_rooms # Show all available rooms
# Create and new customer to the hotel
hotel.add_customer("Ramesh", "121212", 9876543211, "23, Third cross", "Bangalore", "Karnataka", "India", "569004") 
customer = hotel.customer[0]# loading the customer
hotel.check_in customer, "Deluxe" # checkin the deluxe room
hotel.find_customer "121212" #find the customer using id
hotel.check_out customer #checkout customer rooms based on customer choice
customer.name= "Ramesh R" #Update customer name
customer.city="Bangalore" #Update customer city
customer.state="KN" #Update the customer state
# Showing the customer details
p "Customer Details:"
p(customer.customer_details)
```