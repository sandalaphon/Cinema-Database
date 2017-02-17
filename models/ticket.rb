class Ticket

attr_reader :id, :film_id, :customer_id
def initialize( options )
@id = options['id'].to_i if options['id']
@film_id = options['film_id'].to_i if options['film_id']
@customer_id = options['customer_id'].to_i if options['customer_id']
end

def save()
  sql = "INSERT INTO tickets (film_id, customer_id) 
  VALUES
  (#{film_id}, #{customer_id}) 
  RETURNING id;"
  @id= SqlRunner.run(sql)[0]['id'].to_i
  end













end