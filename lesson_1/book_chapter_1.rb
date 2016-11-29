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



# new_car = MyCar.new(2016, 'black', 'Prius')

# p new_car.speed
# p new_car.speed_up
# p new_car.speed_up
# p new_car.speed_up
# p new_car.speed
# p new_car.brake
# p new_car.speed
# p new_car.shut_off
# p new_car.speed

# p new_car.model
# p new_car.color = 'red'
# p new_car.year

# new_car.spray_paint('silver')
# p new_car.color

# p MyCar.gas_mileage(10, 400)

# puts new_car

# class Person
#   attr_writer :name
#   def initialize(name)
#     @name = name
#   end

#   def to_s
#     "This is #{@name}"
#   end
# end

# bob = Person.new("Steve")
# p bob.name = "Bob"

# puts bob

# class Animal
#   def a_public_method
#     "Will this work? " + a_protected_method
#   end

#   protected

#   def a_protected_method
#     "Yes, I'm protected!"
#   end
# end

# fido = Animal.new
# p fido.a_public_method 


# Create a superclass called Vehicle for your MyCar class to inherit from and move
# the behavior that isn't specific to the MyCar class to the superclass. Create a
# constant in your MyCar class that stores information about the vehicle that
# makes it different from other types of Vehicles.

# Then create a new class called MyTruck that inherits from your superclass
# that also has a constant defined that separates it from the MyCar class in
# some way.


# class Vehicle

#   @@number_of_vehicles = 0

#   attr_accessor :color, :speed
#   attr_reader :model, :year

#   def initialize(year, color, model)
#     @year = year
#     @color = color
#     @model = model
#     @speed = 0
#     @@number_of_vehicles +=1
#   end

#   def speed_up
#     self.speed += 10
#   end

#   def brake
#     self.speed -= 10
#   end

#   def shut_off
#     self.speed = 0
#   end

#   def spray_paint(new_color)
#     self.color = new_color
#   end

#   def to_s
#     "This vehicle is a #{self.color} #{self.model} year #{self.year}."
#   end

#   def self.gas_mileage(gallons, miles)
#     miles/gallons
#   end

#   def self.number_of_vehicles
#     puts "There are #{@@number_of_vehicles} vehicles."
#   end

#   def age
#     puts "Your #{self.model} is #{years_old} years old."
#   end

#   private

#   def years_old
#     Time.new.year - self.year
#   end
  
# end

# module Uberable
#   def carry_passengers
#     puts "This is a passenger vehicle."
#   end
# end

# class MyCar < Vehicle
#   include Uberable
#   DOORS = 5
# end


# class MyTruck < Vehicle
#   DOORS = 2
# end

# puts fiesta = MyCar.new(2012, 'white', 'Ford Fiesta')
# puts pick_up = MyTruck.new(2010, 'red', 'Ford Tundra')
# Vehicle.number_of_vehicles
# fiesta.carry_passengers


# puts MyCar.ancestors
# puts MyTruck.ancestors
# puts Vehicle.ancestors

# # Add a class variable to your superclass that can keep track of the number of
# # objects created that inherit from the superclass. Create a method to print out
# # the value of this class variable as well.

# p fiesta.speed_up
# p fiesta.speed_up
# p fiesta.speed_up
# p fiesta.speed_up

# fiesta.age

class Student
  attr_accessor :name
  attr_writer :grade

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade >= other_student.grade
  end

  protected

  def grade
    @grade
  end

end

joe = Student.new('Joe', 9)
bob = Student.new('Bob', 5)

puts "Well done!" if joe.better_grade_than?(bob)

#bob.grade