class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
p oracle.predict_the_future

# the result of calling #Oracle::predict_the_future on object oracle is the
# return of a string starting with "I will " and ending with one of the string 
# values of the array returned by the instance method choices.

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
p trip.predict_the_future

# now the return value will be a string starting with "I will " and ending with
# one of the string values of the array returned by #RoadTrip::choices instance
# method. When calling trip.predict_the_future the looking path is
# RoadTrip > Oracle, which means the instance method choices from RoadTrip will
# overwrite the one in Oracle.

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

product = Orange.new
product.flavor("Citric!")
p Orange.ancestors

# product is an object from the class Orange, so when a method is called on
# product it will first be looked for inside Orange class definition. If it 
# can't be found, then it will be looked for at the module included in Orange.

# an object's ancestors can be found by calling ancestors on it's class;

class BeesWax
  attr_accessor :type
  
  def initialize(type)
    @type = type
  end
  
  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end

BeesWax.new('nice type').describe_type

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
    puts @@cats_count
  end

  def self.cats_count
    @@cats_count
  end
end

pussy = Cat.new('siamese')
kitty = Cat.new('stray')
p Cat.cats_count

# a class variable is accessible from every instance of that class. Which means
# it's very useful for counting instances like in this case. 

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
  
  def play
    "Start the Bingo game!"
  end
end

p Bingo.new.play

# The benefits of using OOP in Ruby? Structuring your code, Making it harder to
# mess something unintentionally, giving it a narrative.

# Abstraction
# Exposing functionality only when it's needed
# Avoid duplication
# Build apps faster reusing previous code
# Easier to manage complex applications