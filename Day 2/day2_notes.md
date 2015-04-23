#Intro to Ruby & Databases Day 2

##BDD With RSpec

This is  a lot like testing in JS with Mocha and Chai, but using RSpec.

###The Test-Driven Development (TDD) Cycle

* **Red:** First write failing tests that state what you expect from the code
  you'll be testing
* **Green:** Write the code to satisfy the tests, and work until the tests pass.
* **Refactor:** You can now refactor your code without fear, since anything you
  break will pop up immediately as failed tests.

###RSpec

The test framework we'll be using is RSpec, which is delivered as a _gem_: 
`gem install rspec`.

**NOTE:** `gem install` wasn't working on Windows due to a bug in version 2.2.2 of RubyGems. This was fixed by [installing v2.2.3](https://gist.github.com/luislavena/f064211759ee0f806c88).

```ruby
require('rspec')
require('pig_latin')

# The thing you 'describe' is the "system under test"
describe('pig_latin') do
  it('adds "ay" to the end of words') do
    expect(pig_latin('adam')).to(eq('adamay'))
  end
end
```
