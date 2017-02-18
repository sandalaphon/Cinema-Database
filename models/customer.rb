class Customer 
attr_accessor :name, :funds
attr_reader :id
def initialize ( options )
@id = options['id'].to_i if options['id']
@name = options['name']
@funds = options['funds'].to_i
end

def save()
  sql= "INSERT INTO customers 
  (name, funds) 
  VALUES 
  ('#{@name}', #{@funds})
  RETURNING *;"
  result = SqlRunner.run(sql)
   
  @id = result[0]['id'].to_i
end

def self.delete_all
  sql = "DELETE FROM customers"
  SqlRunner.run(sql)
  end

  def update
    sql= "UPDATE customers SET (name, funds
    ) = (
    '#{@name}', #{@funds})
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM customers"
    Customer.get_many(sql)
  end

def self.get_many(sql)
      results=SqlRunner.run(sql)
      return results.map{|customer| Customer.new(customer)}
end

def delete
  sql = "DELETE FROM customers WHERE id = #{@id}"
  SqlRunner.run(sql)
end

def films
  sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE tickets.customer_id = #{@id}"
  results = Film.get_many(sql)
  film_names=[]
  results.each {|film| film_names+=[film.title]}
  puts "#{self.name} has bought #{results.length} tickets. To see #{film_names.join(", ")}\n"
  return results
  end

def tickets
  sql = "SELECT * FROM tickets WHERE customer_id = #{@id}"
  return Ticket.get_many(sql)
end

def bookings
  film_names = self.tickets.map{|ticket| ticket.get_film.title}
  magic_hash = Hash.new(0)
  film_names.each {|filmname| magic_hash[filmname] +=1 }
  if film_names.length != 0
  puts "#{self.name} has "
  magic_hash.each{|filmname, no_tickets| puts "#{no_tickets} tickets to see #{filmname}"}
else puts "#{self.name} has no current bookings"
  end
  end



end