# module Speed
#   def go_fast
#     puts "I am a #{self.class} and going super fast!"
#   end
# end

# class Car
#   include Speed
#   def go_slow
#     puts "I am safe and driving slow."
#   end
# end

# class Truck
#   include Speed
#   def go_very_slow
#     puts "I am a heavy truck and like going very slow."
#   end
# end

# fiesta = Car.new

# fiesta.go_fast

# class AngryCat
#   def hiss
#     puts "Hisssss!!!"
#   end
# end

# kitty = AngryCat.new

# p kitty

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

hot_pizza = Pizza.new("cheese")
orange    = Fruit.new("apple")

p hot_pizza
p hot_pizza.instance_variables
p orange

class Cube
  
  def initialize(volume)
    @volume = volume
  end
end

p Cube.new(30).instance_variable_get("@volume")