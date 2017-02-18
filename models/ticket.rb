class Ticket

attr_reader :id, :film_id, :customer_id
def initialize( options )
@id = options['id'].to_i if options['id']
@film_id = options['film_id'].to_i if options['film_id']
@customer_id = options['customer_id'].to_i if options['customer_id']
end

def save()
  x=get_film.price
  y=get_customer.funds
  cu=get_customer
  cu.funds=y-x
  cu.update
  
  sql = "INSERT INTO tickets (film_id, customer_id) 
  VALUES
  (#{film_id}, #{customer_id}) 
  RETURNING id;"
  @id= SqlRunner.run(sql)[0]['id'].to_i
  
  end


  def get_customer
    sql= "SELECT * FROM customers WHERE customers.id=#{@customer_id}
    "
    result= SqlRunner.run(sql)
    return Customer.new(result[0])

  end

    def get_film
      sql = "SELECT * FROM films WHERE films.id = #{@film_id};"
      result = SqlRunner.run(sql)
      return Film.new(result[0])
    end

    def self.get_many(sql)
      tickets = SqlRunner.run(sql)
      return tickets.map {|ticket| Ticket.new(ticket)}
    end
 

  def self.all
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    return tickets.map{|ticket| Ticket.new(ticket)}
  end

  def self.delete_all
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

# update UNTESTED and not currently needed, if another column is added then may uncomment this

  # def update
  #   sql = "UPDATE tickets SET (film_id, customer_id
  #   )=(#{@film_id}, #{@customer_id})
  #   WHERE id = #{@id}"
  #   SqlRunner.run(sql)
  # end

def delete
  sql = "DELETE FROM tickets WHERE id = #{@id}"
  SqlRunner.run(sql)
end

def film
  sql = "SELECT * FROM films WHERE films.id = #{@film_id}"
  return Film.get_many(sql)
  end

  def customer
    sql = "SELECT * FROM customers WHERE customers.id = #{customer_id}"
    return Customer.get_many(sql)
  end
end