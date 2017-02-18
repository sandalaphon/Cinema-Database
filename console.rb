require ('pry')
require_relative('./db/sql_runner.rb')
require_relative('./models/film.rb')
require_relative('./models/customer.rb')
require_relative('./models/ticket.rb')


Ticket.delete_all
Customer.delete_all
Film.delete_all

customer1 = Customer.new({
  'name' => "Charlie Brown", 
  'funds' => 120
  })
customer1.save

customer2 = Customer.new({
  'name' => "John D Rockefeller", 
  'funds' => 400000000000
  })
customer2.save

customer3 = Customer.new({
  'name' => "Albert Einstein", 
  'funds' => 40000
  })
customer3.save

customer4 = Customer.new({
  'name' => "Julius Caesar", 
  'funds' => 3800000
  })
customer4.save

customer5 = Customer.new({
  'name' => "Socrates", 
  'funds' => 38
  })
customer5.save



film1 = Film.new({
 'title' => "Pulp Fiction",
 'price' => 10
  })
film1.save 

film2 = Film.new({
 'title' => "Spartacus",
 'price' => 12
  })
film2.save 

film3 = Film.new({
 'title' => "The Matrix",
 'price' => 12
  })
film3.save 

film4 = Film.new({
 'title' => "Star Wars",
 'price' => 12
  })
film4.save 

film5 = Film.new({
 'title' => "The Fifth Element",
 'price' => 12
  })
film5.save 

ticket1 = Ticket.new({
 'film_id' => film1.id,
 'customer_id' => customer2.id,
 'show_time' => 1200
  })
ticket1.save

ticket2 = Ticket.new({
 'film_id' => film1.id,
 'customer_id' => customer1.id,
 'show_time' => 2100
  })
ticket2.save

ticket3 = Ticket.new({
 'film_id' => film2.id,
 'customer_id' => customer2.id,
 'show_time' => 1700
  })
ticket3.save

ticket4 = Ticket.new({
 'film_id' => film3.id,
 'customer_id' => customer4.id,
 'show_time' => 2200
  })
ticket4.save

ticket5 = Ticket.new({
 'film_id' => film2.id,
 'customer_id' => customer2.id,
 'show_time' => 1500
  })
ticket5.save

ticket6 = Ticket.new({
 'film_id' => film5.id,
 'customer_id' => customer5.id,
 'show_time' => 1830
  })
ticket6.save

binding.pry
nil