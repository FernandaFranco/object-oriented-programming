# class Dog
#   def speak
#     'bark!'
#   end

#   def swim
#     'swimming!'
#   end
# end

# class Bulldog < Dog
#   def swim
#     'can`t swim!'
#   end
# end

# teddy = Dog.new
# puts teddy.speak           # => "bark!"
# puts teddy.swim           # => "swimming!"

# billy = Bulldog.new
# puts billy.swim
# puts billy.speak

class Pet
  def speak
    'inhuman sound!'
  end
  
  def run
    'running!'
  end
  
  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    'can`t swim!'
  end
end

class Cat < Pet
  def speak
    "meow!"
  end
end
  
fofo = Cat.new
dodo = Dog.new

puts fofo.speak
puts dodo.speak


pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

puts pete.run                # => "running!"
puts pete.speak              # => NoMethodError

puts kitty.run               # => "running!"
puts kitty.speak             # => "meow!"
#puts kitty.fetch             # => NoMethodError

puts dave.speak              # => "bark!"

puts bud.run                 # => "running!"
puts bud.swim                # => "can't swim!"


# pets > dog > bulldog
# pets > cat