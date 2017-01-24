# class InvoiceEntry
#   attr_reader :quantity, :product_name

#   def initialize(product_name, number_purchased)
#     @quantity = number_purchased
#     @product_name = product_name
#   end

#   def update_quantity(updated_count)
#     # prevent negative quantities from being set
#     @quantity = updated_count if updated_count >= 0
#   end
# end

# invoice = InvoiceEntry.new("oranges", 2)
# invoice.update_quantity(60)

# p invoice.quantity

# class Greeting
#     def greet(message)
#         puts message
#     end
# end

# class Hello < Greeting
#   def hi
#     self.greet('Hello')
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet('Goodbye')
#   end
# end

# Hello.new.hi
# Goodbye.new.bye

class KrispyKreme
  attr_reader :filling_type, :glazing
  
  def initialize(filling_type, glazing)
    @filling_type = filling_type 
    @glazing = glazing
  end
  
  def to_s
    (filling_type ? filling_type : "Plain") + (glazing ? " with #{glazing}" : "")
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
puts donut2
puts donut3
puts donut4
puts donut5

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

comp = Computer.new
comp.create_template
p comp.show_template

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    template
  end
end

comp = Computer.new
comp.create_template
p comp.show_template

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    puts "I want to turn on the light with a brightness level of super high and a colour of green"
  end

end

Light.information