# How do we create an object in Ruby? Give an example of the creation of an object.

# new_string_object = String.new

# p new_string_object

# class Humanity
# end

# p bob = Humanity.new

# What is a module? What is its purpose? How do we use them with our classes? 
# Create a module for the class you created in exercise 1 and include it properly.

# module Poop
#   def poop
#     "I just went to the bathroom in my pants!"
#   end
# end

# class Humanity
#   include Poop
# end

# p karen = Humanity.new

# p karen.poop

# p Humanity.ancestors

# Create a class called MyCar. When you initialize a new instance or object of
# the class, allow the user to define some instance variables that tell us the
# year, color, and model of the car. Create an instance variable that is set to
# 0 during instantiation of the object to track the current speed of the car as
# well. Create instance methods that allow the car to speed up, brake, and shut
# the car off.

# Add a class method to your MyCar class that calculates the gas mileage of any 
# car.

class MyCar

  attr_accessor :color, :speed
  attr_reader :model, :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up
    self.speed += 10
  end

  def brake
    self.speed -= 10
  end

  def shut_off
    self.speed = 0
  end

  def spray_paint(new_color)
    self.color = new_color
  end

  def self.gas_mileage(gallons, miles)
    miles/gallons
  end

  def to_s
    "This car is a #{self.color} #{self.model} year #{self.year}."
  end
end

new_car = MyCar.new(2016, 'black', 'Prius')

# p new_car.speed
# p new_car.speed_up
# p new_car.speed_up
# p new_car.speed_up
# p new_car.speed
# p new_car.brake
# p new_car.speed
# p new_car.shut_off
# p new_car.speed

p new_car.model
p new_car.color = 'red'
p new_car.year

new_car.spray_paint('silver')
p new_car.color

p MyCar.gas_mileage(10, 400)

puts new_car

class Person
  attr_writer :name
  def initialize(name)
    @name = name
  end

  def to_s
    "This is #{@name}"
  end
end

bob = Person.new("Steve")
p bob.name = "Bob"

puts bob





