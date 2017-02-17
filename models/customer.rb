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
   b=result[0]
  @id = b['id'].to_i
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
  Film.get_many(sql)
  end




end