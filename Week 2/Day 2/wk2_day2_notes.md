#Intro to Ruby & Databases Week 2, Day 2

##Class Methods & Class Variables

###Class Methods

The methods we've seen so far can exist independently (global methods), or as 
part of the instances of a class. But what if you want to know something about 
all the instances of that class?

###Class Variables

What we've covered so far about variables:

* `local_variable = 1` -- Defined inside a method, these are only accessible
  inside that method.
* `@instance_variable = 2` -- Defined in a method that's part of a class, these 
  are accessible in any of the methods for each instance of that class.
* `@global_variable = 3` -- Defined outside any class or method, globals are 
  accessible anywhere.

##Symbols, `attr_reader` & Friends, Initializing with Hashes

###Symbols

Symbols are a lot like strings, but are immutable. They're faster and easier for
Ruby to deal with, and are meant for internal use within the program (to handle 
text that won't be changing).

###`attr_reader`, `attr_writer, and `attr_accessor`

The `attr_reader` method is a shorthand for creating a getter for an instance
variable. Similarly, `attr_writer` creates a setter (of the `method=` variety).
The `attr_accessor` creates both for each symbol passed to it.

```ruby
class Task
  @@all_tasks = []
  attr_accessor :description, :created

  # more code...
end

# later...
task.description = 'foo'
task.description  #=> 'foo'
```

###Initializing with a Hash

