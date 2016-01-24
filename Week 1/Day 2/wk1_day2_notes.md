# Intro to Ruby & Databases Week 1, Day 2

## BDD With RSpec

https://canvas.instructure.com/courses/922390/pages/bdd-with-rspec?module_item_id=7145456
https://github.com/rspec/rspec-core <br>
https://relishapp.com/rspec/rspec-core/docs <br>
http://player.vimeo.com/video/87925946

This is  a lot like testing in JS with Mocha and Chai, but using RSpec.

### The Test-Driven Development (TDD) Cycle

* **Red:** First write failing tests that state what you expect from the code
  you'll be testing
* **Green:** Write the code to satisfy the tests, and work until the tests pass.
* **Refactor:** You can now refactor your code without fear, since anything you
  break will pop up immediately as failed tests.

### RSpec

The test framework we'll be using is RSpec, which is delivered as a _gem_:
`gem install rspec`.

**NOTE:** `gem install` wasn't working on Windows due to
[a bug](https://gist.github.com/luislavena/f064211759ee0f806c88) in the version
of RubyGems that came with [RailsInstaller](http://railsinstaller.org/). You can
fix this by
[installing an update](https://gist.github.com/luislavena/f064211759ee0f806c88#installing-using-update-packages-new).

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
