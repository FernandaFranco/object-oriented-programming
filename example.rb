module Teeth
end

class Pet
    include Teeth
    def swim
        "some pets swim"
    end
end

module Swim
    def swim
        "swim swim little swimmer"
    end
end

module NoSwim
    def swim
        "me no swim"
    end
end

class Dog < Pet
    include NoSwim
    include Swim
end

puts Dog.new.swim
puts Dog.ancestors