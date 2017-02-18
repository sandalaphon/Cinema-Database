class Film
attr_accessor :title, :price
attr_reader :id
def initialize( options )
 @id = options['id'].to_i if options['id']
 @title = options['title']
 @price = options['price'].to_i
end

def save()
sql = "INSERT INTO films (title, price)
VALUES
('#{@title}', #{@price})
RETURNING id"
film_id = SqlRunner.run(sql)[0]
@id = film_id['id'].to_i
end

def self.delete_all
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
end

def self.all
  sql = "SELECT * FROM films"
  Film.get_many(sql)
end

def self.get_many(sql)
  results=SqlRunner.run(sql)
  return results.map{|film| Film.new(film)}
  end

  def update
    sql = "UPDATE films SET (title, price
    )=(
    '#{@title}', #{price})
    WHERE
    id = #{@id}
    "
    SqlRunner.run(sql)
  end

  def customers
    sql= "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE tickets.film_id = #{@id};"
      results= Customer.get_many(sql)
      number_customers=results.length
      customer_names=[]
      results.each{|customer| customer_names+=[customer.name]}

      puts "The following #{number_customers} are going to see #{self.title}: #{customer_names.join(", ")}\n"
      return results
  end

  def self.get_many(sql)
    results = SqlRunner.run(sql)
    return results.map {|film| Film.new(film)}
  end

  def tickets
    sql = "SELECT * FROM tickets WHERE tickets.film_id = #{@id}"
   result= Ticket.get_many(sql)
   puts "#{result.length} tickets have been sold to #{self.title}"
   return result
  end

def pop_time
  #The following works fine but prefer the .max method due to better readability
  # showtimes = self.tickets.map{|ticket| ticket.show_time}.sort
  # number_most_pop = showtimes.count(showtimes[0])
  showtimes = self.tickets.map{|ticket| ticket.show_time}
  number_most_pop = showtimes.count(showtimes.max)
  puts "The most popular showtime of #{self.title} is the #{showtimes[0]} showing where #{number_most_pop} tickets have been sold"

end

end