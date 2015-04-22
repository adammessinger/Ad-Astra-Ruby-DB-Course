#Intro to Ruby & Databases Day 1

##Ruby Basics

https://canvas.instructure.com/courses/922390/pages/ruby-basics  
http://www.tutorialspoint.com/ruby/index.htm <br>
http://ruby-doc.org/core-2.1.5/ 

* Server-side
* About 20 years old -- mature but not "old"
* Interpreted
* Loosely Typed
* Motivated by a desire for clean syntax -- easy to write, read, and use
* You can define your own operators on any type, for example to implement
  the (missing) `++` functionality
* Comment with `#` (except when you're interpolating -- see below).
* Idiomatic Ruby generally uses snake_case for all identifiers, rather than
  camelCase or StudlyCaps.
* Equality operators are [kind of weird](http://stackoverflow.com/questions/7156955/whats-the-difference-between-equal-eql-and).

**NOTE:** Raise numbers to a power with `**` operator. Can make large numbers more readable with underscores instead of commas -- `4_123_876`.

###Variables

* Integer
  * Fixnum for -2<sup>30</sup> to 2<sup>30-1</sup> (32-bit)
    or -2<sup>62</sup> to 2<sup>62-1</sup> (64-bit)
  * Bignum for any integer outside the above range(s)
* Float
* String
* Boolean
* Array
* Time (date and time)
* Hash (key-value hash, like JS objects or PHP associative arrays)
* Range (a set of integers with a start and end; useful for loops,
  slicing out part of a string or array -- `1..10`)
* Nil (AKA NilClass, same as null in other languages)

Depending on type, a value (and therefore a variable containing that value)
will have several methods. This is because values of all types are objects,
similar to JS (which automatically 
["boxes" and "unboxes"](http://stackoverflow.com/a/13056) its primative types 
when you call their methods/properties, e.g. `'foo'.toUpperCase()`). 

You can get a list of all the methods available for a value of a certain type 
by calling the `.methods` method -- `4.methods` will get you a list of all the 
integer methods. You can learn a variable's type by calling the `.class` method on it: `my_array.class` returns "Array".

**NOTE:** You don't need to use `var` or any other keyword to assign a 
variable. Just name it and assign it (like PHP). You cannot declare a variable 
without assigning _something_ to it.

**NOTE:** In Ruby, only `false` and `nil` are 
[falsey](http://james.padolsey.com/javascript/truthy-falsey/). Yes, _even zero 
is truthy._

###Methods

* Methods that end in `?` by convention return a Boolean. Follow this in your 
  own code as well.
* Methods that end in `!` modify the thing they were called on: 
  * `my_array.reverse` returns an array with the elements ordered opposite
    those of `my_array`.
  * `my_array.reverse!` does the same thing, _and_ reverses the order of 
    `my_array`.
* You only need parens for a method call if the method takes arguments (but 
  you can add them anyway if you want):
  * `5.even?` returns `false`
  * `5.even?()` returns `false`
  * `5.between?(2, 9)` returns `true`
  * `5.between? 2, 9` returns `true`
  * `5.between?` -- **error**
* Methods are chainable: `4.5.round.odd?` returns `true`

###Strings

* Concat with `+` but this can't coerce types
* Can do string interpolation of vars with double quotes and `#{var_name}`:
  `"I am #{age} years old."`
  * You can also interpolate basic expressions (e.g. math but not method 
    calls): `"In #{age} years, I will be #{age + from_now} years old."`
* Can slice out part of the string with a range or with an argument-like 
  syntax:
  * `my_var[2..6]` -- from char 2 to char 6
  * `my_var[2, 6]` -- from char 2, give me 6 chars

###Arrays

* Like JS arrays, they can contain any type.
* Can call methods that usually return a new array, like `.sort` and
  `.reverse`, with a bang (`!`) to change the array the method was called on.
* Has the usual `pop`, `push`, `shift`, `unshift`, `split`, `join`, `sort`,
  `reverse` methods.
* Also has `.first(n)` and `.last(n)` to return the first or last _n_ elements
  on the array.

###Hashes

```ruby
my_hash = {
  4    => 'four',
  '4'  => 'quatro',
  1..4 => 'first four'
}
```

* A lot like JS objects, but any type can be a key instead of just strings. So 
  really, more like an ECMAScript 6 `Map`.
* Access properties via `hash[key]` syntax. You can't use dot notation like
  in JS.

##Branching and Iteration

https://canvas.instructure.com/courses/922390/pages/branching-and-looping-in-ruby

###Branching

* No parentheses necessary around conditions.
* Blocks start with `if [condition]` (e.g. `if foo == bar`) and end with `end`.
* Ruby's version of `else if` is, weirdly, `elsif`.

###Iteration

* Use the "each" method on arrays, ranges, and hashes (see above link
  for syntax).
  * For arrays, you define the inner var for the array value on each iteration.
  * For ranges, you define the inner var for the number in the range.
  * For hashes, you define the inner vars for key and value on each iteration.
* There are other ways to loop without calling a method on a variable or 
  value, but we'll get to that later.

##Global Methods

https://canvas.instructure.com/courses/922390/pages/global-methods 

* `rand(5)` gives you a random number between 0 and 5
* `puts 'string'` prints the string followed by a newline
* You can define your own methods with the `def` keyword
* Unless you _explicitly say otherwise,_ the return value of your functions 
  will always be the last evaluated expression.