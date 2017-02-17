require ('pry')
require_relative('./db/sql_runner.rb')
require_relative('./models/film.rb')
require_relative('./models/customer.rb')
require_relative('./models/ticket.rb')


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

ticket1 = Ticket.new({
 'film_id' => film1.id,
 'customer_id' => customer2.id
  })
ticket1.save

binding.pry
nil