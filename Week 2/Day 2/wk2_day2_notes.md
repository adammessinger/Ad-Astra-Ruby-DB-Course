#Intro to Ruby & Databases Week 2, Day 2

##Class Variables & Class Methods

There are some ugly bits of the to-do program we've been working on that class
variables and class methods will help us fix:

```ruby
# we set a global variable up at the top of the program...
@list = []

# ...then later we add a new task to the list by pushing onto that global array:
@list.push(Task.new(user_description))
```

This shouldn't really be the job of the user interface -- that's poor separation
of concerns. Wouldn't it be better to keep track of all the tasks in the class,
adding and removing tasks there?

###Class Variables

What we've covered so far about variables:

* `local_variable = 1` -- Defined inside a method, these are only accessible
  inside that method.
* `@instance_variable = 2` -- Defined in a method that's part of a class, these
  are accessible in any of the methods for each instance of that class.
* `@global_variable = 3` -- Defined outside any class or method, globals are
  accessible anywhere.

Unlike an instance variable, a **class variable** is for holding information
about all instances of the class. Like an instance variable, a class variable is
accessible to all of the class's methods. Class variables are defined within the
class they belong to, and start with `@@`:

```ruby
class Task
  @@all_tasks = []

  def save
    # Recall that "self" is a way for instance methods to refer to the instance
    # they are called on.
    @@all_tasks.push(self)
  end
end
```

###Class Methods

The methods we've seen so far can exist independently (global methods), or as
part of the instances of a class. But what if you want to know something about
all the instances of that class? This is where **class methods** come into play.
Class methods are named in the pattern `ClassName.method_name`:

```ruby
class Task
  @@all_tasks = []

  def Task.all
    @@all_tasks
  end

  def Tasks.clear
    @@all_tasks = []
  end

  def save
    @@all_tasks.push(self)
  end
end
```

When we write an instance method (in documentation, not in code), we write it
as `ClassName#instance_method`, for class methods `ClassName.class_method` (in
both documentation and code). It's pretty common to extend that way of writing
into our specs:

```ruby
require 'task'
require 'rspec'

describe Task do
  describe '.all' do
    it 'is empty at first' do
      expect(Task.all).to(eq [])
    end
  end

  describe '#save' do
    it 'adds a task to the array of saved tasks' do
      test_task = Task.new('wash the lion')
      test_task.save
      expect(Task.all).to(eq [test_task])
    end
  end
end
```

##Symbols, `attr_reader` & Friends, Initializing with Hashes

###Symbols

Symbols are a lot like strings, but are immutable. They're faster and easier for
Ruby to deal with, and are meant for internal use within the program (to handle
text that won't be changing). "A string is for human-readable input and output;
a symbol is for machine-readable input and output."

Symbols look like this: `:my_symbol`. See the next section for some examples.

###`attr_reader`, `attr_writer, and `attr_accessor`

The `attr_reader` method is a shorthand for creating a getter for an instance
variable. Similarly, `attr_writer` creates a setter (of the `property=`
variety). The `attr_accessor` creates both for each symbol passed to it.

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

This is almost exactly like passing an object hash as a function argument in JS:

```ruby
Task.new({:name => 'learn', :description => 'learn Ruby'})

class Task
  def initialize(attributes)
    @description = attributes[:description]
    @name = attributes[:name]
  end
end
```

##Debugging in Ruby

(copy-pasted from course materials...)

[Video](http://player.vimeo.com/video/88805430)

Ruby has a similar set of debugging tools to JavaScript.

`puts` is much like `alert()`. When you aren't sure where something in your code
is broken, you can use `puts` to see where you get to. I often will write 
`puts '*' * 88`, which will make a long line of stars across the screen when that
line is reached, making it really clear that I got to that point (or didn't).

`p` is a bit like `console.log()`. It's like `puts`, but when you `p` an object, 
the output includes all of the instance variables and their values.

`binding.pry` is like `debugger`. Install the `pry` gem and add `require 'pry'` 
to any file; then stick `binding.pry` anywhere in that file, and when that point 
is reached, you'll be dropped into an IRB-like console. In fact, many developers
prefer Pry over IRB; you can start it from the command line by simply typing 
`$ pry`.

Pry is ridiculously cool and powerful. If you'd like to learn more about it, 
check out the [introductory screencast](http://pryrepl.org/screencasts.html).
