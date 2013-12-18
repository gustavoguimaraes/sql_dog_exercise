require 'mysql2'
require 'debugger'
 
class Dog
  
  @@db = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "dogs")

  attr_accessor :name, :color, :id

  def initialize(name,color, id=nil)
    @name = name
    @color = color
    @id = id
  end

  def db
    @@db 
  end
    
    def self.db
      @@db
    end

    def mark_saved!
      self.id = self.db.last_id if self.db.last_id > 0
    end
 
 
 def self.find(id)
  matched_rows = []
  query = self.db.query("SELECT *
    FROM dogs
    WHERE id = #{id}")
   query.each do |row|
    matched_rows << Dog.new(row["NAME"], row["color"], row["id"])
   end
   matched_rows.first
 end

 def self.find_by_name(name)
  db.query("SELECT *
    FROM dogs
    WHERE name = '#{name}'").first
 end

  def self.find_by_color(color)
    self.db.query("SELECT *
     FROM dogs
     WHERE color = '#{color}'").first
  end


 def insert
    self.db.query("
      INSERT INTO dogs (name, color)
      VALUES ('#{self.name}', '#{self.color}')
      ")
    "The dog #{self.name} has been inserted"
    self.id = db.last_id
  end 

  def update
    db.query("UPDATE dogs
      SET name = '#{name}', color = '#{color}'
      WHERE id = '#{id}'
      ")
    "The dog #{self.name} has been updated"
  end

  def delete
    db.query(" 
      DELETE from dogs
      WHERE id = #{id}
      ")
    "#{self.name} was removed from the database"
  end

end
 
#  dog = Dog.new("bob", "blue")
 
# dog.



# debugger
# puts 'hi'
 
  # color, name, id
  # db
  # find_by_att
  # find
  # insert
  # update
  # delete/destroy
 
  # refactorings?
  # new_from_db?
  # saved?
  # save! (a smart method that knows the right thing to do)
  # unsaved?
  # mark_saved!
  # ==
  # inspect
  # reload
  # attributes