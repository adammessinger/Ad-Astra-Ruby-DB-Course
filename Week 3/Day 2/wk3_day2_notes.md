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

##Join Statements

Joins are a way to combine and/or winnow data from more than one table in a single
query instead of multiple queries. It's been a while, but you did this _tons_ 
when writing reports for Southwestern's fundraising office.

For example, let's say a zoo has a table for its animal trainers, a table for the
animals, and a table that associates trainers with animals in a many-to-many
relationship:

```
 id | species
----+--------
   1| tiger
   2| lion   
   3| gorilla


 id |     name      
----+-----------------
   1| harry houdini
   2| missy mysterious


 id | animal_id | trainer_id
----+-----------+-----------
   1|  1        |1
   2|  2        |1
   3|  1        |2
```

If we want to figure out who all of Harry's animals are without using a join, we 
have to go through two steps. First, we select all of the entries in the join
table, lessons:

```sql
SELECT animal_id FROM lessons WHERE trainer_id = 1;
```

From this statement, we get the animal_ids 1 and 2 back. Now, we have to loop 
through each of these animal_ids and select the corresponding animal:

SELECT * FROM animals WHERE id = 1;
SELECT * FROM animals WHERE id = 2;
To do this more efficiently, we can use a 3-table join:

SELECT animals.* FROM
trainers JOIN lessons ON (trainers.id = lessons.trainer_id)
         JOIN animals ON (lessons.animal_id = animals.id)
WHERE trainers.id = 1;

**NOTE:** The above joins are `INNER JOIN`s. There are multiple types:

* `INNER JOIN` - The data has to exist in both tables.
* `LEFT OUTER JOIN` - The data can exist on the left table in the join but not
  in the right table. For example, if you wanted to include animals without a 
  trainer.
* `RIGHT OUTER JOIN` - Like its left counterpart, except that the optional data
  is on the left side of the join statement.

Some additional resources:

* http://www.sql-join.com/
* http://blog.codinghorror.com/a-visual-explanation-of-sql-joins/
* http://www.w3schools.com/sql/sql_join.asp
