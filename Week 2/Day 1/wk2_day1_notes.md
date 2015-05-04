#Intro to Ruby & Databases Week 2, Day 1

##The OOP Paradigm

A **class** is a definition or template for a thing that has certain properties
and actions. An **object** is an instance of a class. For example, Tod Smith might
be an instance of the Employee class.

All employees, including Tod, would share certain **properties** in common like
`hire_date`. They also share certain **methods**, which are functions that represent
the actions of that object. Methods of an Employee class and its descendant
objects might include `hire` and `terminate`.

##Ruby's Object Model

Everything is an object, even strings (which are objects of the String class).
Even those type classes are themselves subclasses of the Class class. It's kind
of like how objects in JavaScript are descendants of the Object prototype.

Here's how you create a class of your own:

```ruby
class Programmer
  def write_code
    puts 'I teach computers to do magic.'
  end

  def consume_caffeine
    puts 'Coffee is life.'
  end
end
```

In Ruby, a class **must** start with a capital letter and **should** be in
StudlyCaps. It's good practice to limit yourself to one class per file.

To create an instance of a class, call the `new` method on it: `adam = Programmer.new`.

To extend an existing class with new methods, you use the same syntax as above:

```ruby
class Programmer
  def fix_bug
    # TODO: this feature not yet implemented, see issue #3971
  end
end
```

The `self` keyword in Ruby refers to the object that the method using it was
called on, like `this` in some other languages. For example, to extend the
`Integer` class with an `add` method that adds a number to the integer it was
called on:

```ruby
class Integer
  def add(num)
    self + num
  end
end

5.add(3) #=> 8
```

##The `initialize` Method and Instance Variables

###Initialize

The `initialize` method is a special method that gets run when a new instance of
a class is created with `new`.

```ruby
class Rectangle
  def initialize(length, width)
    puts "I am a #{length} by #{width} rectangle."
  end
end

square = Rectangle.new(5, 5)  #=> "I am a 5 by 5 rectangle."
```

You can't use those values you initialize with in other methods, though...

```ruby
class Rectangle
  def initialize(length, width)
    puts "I am a #{length} by #{width} rectangle."
  end

  def square?
    length == width
  end
end

rect1 = Rectangle.new(5, 5)
rect1.square?  #=> error
```

###Instance Variables

You can't use the values passed to `initialize` because they're out of scope for
other methods. We can fix this by using instance variables, which will be in scope
for all methods of every instance of the class.

```ruby
class Rectangle
  def initialize(length, width)
    @length = length
    @width = width

    puts "I am a #{length} by #{width} rectangle."
  end

  def square?
    @length == @width
  end
end

rect1 = Rectangle.new(5, 5)
rect1.square?  #=> true
```

##Global Variables

You create a global variable by prefixing its name with `@` like an instance
variable, but _outside_ any class or method. As in other languages, be careful
with this -- it's easy to shoot yourself in the foot with globals.

```ruby
require './lib/task'

@list = []

def add_task
  puts 'Enter a description of the new task.'
  user_description = gets.chomp
  @list.push(Task.new(user_description))
  puts "Task added.\n\n"
end

def list_tasks
  puts 'Here are all your tasks:'
  @list.each do |task|
    puts task.description
  end
  puts "\n"
end
```

##Getters and Setters

###Getters

You can't access a class's instance variables directly from outside that class
-- they'd be out of scope. To do this, you need to define a method that returns
the variable you want. This is called a **getter**.

```ruby
class Task
  def initialize(description)
    @description = description
  end

  # this is a getter for "description":
  def description
    @description
  end
end
```

###Setters

To change the value of an instance variable from outside the class, you need a
**setter** method. In Ruby, you can end these method's names in `=` to enable a
bit of syntactic sugar. It lets you call the setter like either
`object.property=('value')` _or_ `object.property = 'value'`. If that feels too
weird, or too [magical](http://en.wikipedia.org/wiki/Magic_%28programming%29),
you can always just name your setters something like `set_property` and call
them like any other method.
