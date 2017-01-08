p true.class          # => TrueClass
p true.nil?           # => false
p true.to_s           # => "true"
p true.methods        # => list of methods you can call on the true object


p TrueClass.ancestors

p false.class         # => FalseClass
p false.nil?          # => false
p false.to_s          # => "false"
p false.methods
