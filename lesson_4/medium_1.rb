class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    @quantity = updated_count if updated_count >= 0
  end
end

invoice = InvoiceEntry.new("oranges", 2)
invoice.update_quantity(60)

p invoice.quantity

class Greeting
    def greet(message)
        puts message
    end
end

class Hello < Greeting
  def hi
    self.greet('Hello')
  end
end

class Goodbye < Greeting
  def bye
    greet('Goodbye')
  end
end

Hello.new.hi
Goodbye.new.bye

class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end
end