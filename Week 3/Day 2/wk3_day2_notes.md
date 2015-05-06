#Intro to Ruby & Databases Week 3, Day 2

First, something that got skipped when we went over class methods: there are two
ways to define them...

```ruby
class Task
  def Task.all
  end
end

class Task
  def self.all
  end
end
```

When defining a method, `self` refers to the class that the method is being 
defined on.

In the real world, class methods are virtually always defined using `self` 
rather than the class name. We started out using the class name to provide 
clarity, but you've now graduated to getting to use `self`. :)

Also, you'll often compare two objects of a different class. In that case, 
you'll need some extra logic in your `==` method to make sure you don't get an 
`undefined method` error for the other class:

```ruby
class Task
  def == (another_task)
    self.class == another_task.class && self.name == another_task.name
  end
end
```

##Revisiting the To-Do Program, with SQL


