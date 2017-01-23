class Greeting
  def greet(message)
    puts message
  end
end

# class Hello < Greeting
#   def hi
#     greet("Hello")
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end

# Hello.new.hi

class Hello < Greeting
  def hi
    greet("Hello")
  end
  
  def self.hi
    greeting = Hello.new
    greeting.hi
  end
end

Hello.hi

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

kitty = AngryCat.new(12, "Polo")
kitten = AngryCat.new(3, "Marco")

kitty.name
kitten.name

class Cat
  attr_reader :type
  
  def initialize(type)
    @type = type
  end
  
  def to_s
    "I am a #{type} cat!"
  end
end

cat = Cat.new("tabby")
puts cat

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    @age += 1
  end
end

cat = Cat.new('tabby')
cat.make_one_year_older
cat.make_one_year_older
cat.make_one_year_older
cat.make_one_year_older
p cat.age

