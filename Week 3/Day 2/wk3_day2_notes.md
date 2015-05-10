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
clarity, but you've now graduated to getting to use `self`.

Also, you'll often compare two different instance objects of a class. In that
case, you'll need some extra logic in your `==` method to make sure you don't
get an  `undefined method` error for the other class:

```ruby
class Task
  def == (another_task)
    self.class == another_task.class && self.name == another_task.name
  end
end
```

##Revisiting the To-Do Program, with SQL

For the basics of getting tasks and to-do lists working with SQL, see 
[the course materials](https://canvas.instructure.com/courses/922390/pages/exercise-to-do-with-sql?module_item_id=7145474).
Here are the (copy-pasted) requirements and some tips for the final 
version:

> Follow along with the example of building a to do list. As you go, build a user 
interface. (If you're feeling adventurous, write your user interface using 
[curses](http://www.ruby-doc.org/stdlib-2.0/libdoc/curses/rdoc/Curses.html).) 
Here are the requirements for the project (finish one at a time):

> * Allow users to create tasks, list them out, and delete them.
* Add the ability to have multiple lists. Create a `List#tasks` method that
  returns all the tasks in a particular list.
* When you delete a list, make sure that all of the tasks in that list get
  deleted, too.
* Let users mark tasks as done without deleting them, so that they can view all
  of their completed tasks later. (Retain the ability to delete tasks as well.)
* Build a feature to let users enter a due date.
* Sort tasks by their due date. Check out the [PostgreSQL documentation](http://www.postgresql.org/docs/9.2/static/queries-order.html)
  on `ORDER BY` -- let the database do the sorting, not Ruby.
* Now, let users choose between sorting by soonest due, or latest due. Make class
  methods for these.
* Give users the option to edit a task's description.

> Here are a couple things to be aware of when you work with the pg gem:

> * All of the values returned from in `PG::Results` objects will be strings. It
  is up to you to convert them into the proper Ruby class.
* Booleans are represented by `'t'` and `'f'`.
* The SQL equivalent of `nil` is `NULL`. If you are trying to perform an insert
  and need to leave a value out, you should pass in `NULL`, not `nil`.
