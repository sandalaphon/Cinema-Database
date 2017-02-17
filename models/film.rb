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
end