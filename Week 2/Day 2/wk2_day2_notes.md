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
