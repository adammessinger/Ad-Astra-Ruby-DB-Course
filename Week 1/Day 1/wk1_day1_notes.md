# Intro to Ruby & Databases Week 1, Day 1

## Ruby Basics

https://canvas.instructure.com/courses/922390/pages/ruby-basics
http://www.tutorialspoint.com/ruby/index.htm <br>
http://ruby-doc.org/core-2.1.5/

* Server-side
* About 20 years old -- mature but not "old"
* Interpreted
* Dynamically (but strongly) typed
* Motivated by a desire for clean syntax -- easy to write, read, and use
* You can define your own operators on any type, for example to implement
  the (missing) `++` functionality
* Comment with `#` (except when you're interpolating -- see below).
* Idiomatic Ruby generally uses snake_case for all identifiers, rather than
  camelCase or StudlyCaps.
* Equality operators are [kind of weird](http://stackoverflow.com/questions/7156955/whats-the-difference-between-equal-eql-and).

**NOTE:** Raise numbers to a power with `**` operator. Can make large numbers more readable with underscores instead of commas -- `4_123_876`.

### Variables

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

### Methods

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

### Strings

* Concat with `+` but this can't coerce types
* Can do string interpolation of vars with double quotes and `#{var_name}`:
  `"I am #{age} years old."`
  * You can also interpolate basic expressions (e.g. math but not method
    calls): `"In #{age} years, I will be #{age + from_now} years old."`
* Can slice out part of the string with a range or with an argument-like
  syntax:
  * `my_var[2..6]` -- from char 2 to char 6
  * `my_var[2, 6]` -- from char 2, give me 6 chars

### Arrays

* Like JS arrays, they can contain any type.
* Can call methods that usually return a new array, like `.sort` and
  `.reverse`, with a bang (`!`) to change the array the method was called on.
* Has the usual `pop`, `push`, `shift`, `unshift`, `split`, `join`, `sort`,
  `reverse` methods.
* Also has `.first(n)` and `.last(n)` to return the first or last _n_ elements
  on the array.

### Ranges

http://ruby-doc.org/core-2.1.5/Range.html

> A Range represents an interval -- a set of values with a beginning and an end.
> Ranges may be constructed using the `s..e` and `s...e` literals, or with `::new`.
> Ranges constructed using `..` run from the beginning to the end inclusively.
> Those created using `...` exclude the end value. When used as an iterator,
> ranges return each value in the sequence.
>
> ```ruby
> (-1..-5).to_a      #=> []
> (-5..-1).to_a      #=> [-5, -4, -3, -2, -1]
> ('a'..'e').to_a    #=> ["a", "b", "c", "d", "e"]
> ('a'...'e').to_a   #=> ["a", "b", "c", "d"]
> ```
>
> <cite>[ruby-doc.org: Range](http://ruby-doc.org/core-2.1.5/Range.html)</a></cite>

Ranges aren't quite like any type I've used before. There's more to learn
in the docs, but here are the high points...

Can determine if something would fit within a range using `.cover?` method,
whether it's **actually** in the range using `.include?`. An example from
[a StackOverflow explanation](http://stackoverflow.com/a/21609473):

```ruby
('a'..'z').cover?('yellow') # => true
('a'..'z').include?('yellow') # => false
('yellaa'..'yellzz').include?('yellow') # => true
  ```

Can iterate over a range using `.each`:

```ruby
(10..15).each {|n| print n, ' ' }
# prints: 10 11 12 13 14 15

(2.5..5).each {|n| print n, ' ' }
# raises: TypeError: can't iterate from Float
```

Can return the object that _defines the end of the range_ (not necessarily the
last thing _in_ the range) with `.end`:

```ruby
(1..10).end    #=> 10
(1...10).end   #=> 10
```

Can also use `.last`, which acts like `.end` when called with no arguments but
returns an array of the last _n_ things in the range if called with an integer arg:

```ruby
(10..20).last      #=> 20
(10...20).last     #=> 20
(10..20).last(3)   #=> [18, 19, 20]
(10...20).last(3)  #=> [17, 18, 19]
(10...20).last(1)  #=> [19]
```

Much like `.last`, the `.first` method can give you the first or first _n_
things in a range:

```ruby
(10..20).first     #=> 10
(10..20).first(3)  #=> [10, 11, 12]
```

Get the largest and smallest values in a range with `.max` and `.min`:

```ruby
(10..20).min  #=> 10
(10..20).max  #=> 20
```

### Hashes

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

## Branching and Iteration

https://canvas.instructure.com/courses/922390/pages/branching-and-looping-in-ruby

### Branching

* No parentheses necessary around conditions.
* Blocks start with `if [condition]` (e.g. `if foo == bar`) and end with `end`.
* Ruby's version of `else if` is, weirdly, `elsif`.

```ruby
if milk_is_sour && car_has_gas
  'Time to go to the store.'
elsif milk_is_sour && !car_has_gas
  'Time to gas up the car.'
else
  'Yum!'
end
```

Ruby also has the `unless` comparison operator:

```ruby
unless milk_is_sour
  'Yum!'
else
  'Time to go to the store.'
end
```

### Iteration

* Use the `each` method on arrays, ranges, and hashes (see above link
  for syntax).
  * For arrays, you define the inner var for the array value on each iteration.
  * For ranges, you define the inner var for the number in the range.
  * For hashes, you define the inner vars for key and value on each iteration.
* There are other iteration methods, and also ways to loop without calling a
  method on a variable or value. We'll get to that later, or
  [you can find it here](http://www.skorks.com/2009/09/a-wealth-of-ruby-loops-and-iterators/).

Iterating over an array:

```ruby
# one-liner:
planets_from_sol.each { |name| print "#{{name}} "  }
#=> Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune

# block:
planets_from_sol.each do |name|
  print name + (name == planets_from_sol.last ? '' : ', ')
end
#=> Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
```

Over a range:

```ruby
(1..10).each { |i| print "#{i} "  }  #=> 1 2 3 4 5 6 7 8 9 10
```

Over a hash:

```ruby
fave_cookies_by_person_fname.each do |name, cookie|
  puts "#{name} loves to eat #{cookie}."
end
#=> Adam loves to eat chocolate chip.
#=> Liz loves to eat Double Stuff Oreos.
#=> Mila loves to eat salmon cat treats.
```

## Global Methods

https://canvas.instructure.com/courses/922390/pages/global-methods
https://player.vimeo.com/video/87877568

* `rand(5)` gives you a random number between 0 and 5
* `puts 'string'` prints the string followed by a newline
* You can define your own methods with the `def` keyword
* Unless you _explicitly say otherwise,_ the return value of your functions
  will always be the last evaluated expression.
