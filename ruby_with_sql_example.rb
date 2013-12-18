require 'mysql2'
require 'debugger'

class Dog
    @@db = Mysql::Client.new(:host => "localhost")
  attr_accessor :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def self.db
    @@db
  end
  
  def db
    @@db
  end

  def self.find(id)
    db.query("SELECT * 
    FROM dogs
    WHERE id = #{id}")
    if results.first.nil?
      return "no results"
    else
      return self.new_from_db(results.first)
    end
  end 

  def self.new_from_db(row)
    dog = Dog.new(row["name"], row["color"])
    dog
  end

  def mark_as_saved!
    # last_id is mysql2 method.
    self.id = self.db.last_id if self.db.last_id > 0
  end

  def insert
    db.query("
      INSERT INTO dogs (name, color)
      VALUES ('#{self.name}', '#{self.color}')
      ")
  end 

  def self.find_by_name(name)

  end

  def self.find_by_color(color)

  end

end