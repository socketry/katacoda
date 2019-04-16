Now that we have `async` installed, lets try writing a simple script (in `~/script.rb`):

## Source Code

```ruby
require 'async'

# example function that takes a random ammount of time to complete
def example(id)
  Async do |task|
    value = rand # get random value
    puts "Putting #{id} to sleep for #{value} seconds."
    task.sleep(value) 
    puts "#{id} woke up!"
  end
end

# asynchronously run five example functions
Async do
  5.times do |index|
    example(index)
  end
end
```

## Run the Script

Once we add the code to `script.rb`, we can run it:
`ruby script.rb`{{execute}}

Which will print something like:
```
Putting 0 to sleep for 0.9574802144898436 seconds.
Putting 1 to sleep for 0.7262078954848514 seconds.
Putting 2 to sleep for 0.7405045651373127 seconds.
Putting 3 to sleep for 0.034974281190434775 seconds.
Putting 4 to sleep for 0.7185753646713757 seconds.
3 woke up!
4 woke up!
1 woke up!
2 woke up!
0 woke up!
```

As we can see, each `example()` function is called in order, but depending on the randomly generated value, it will return out-of-order, having run concurrently.

> **Note**: If we were to remove the `Async { ... }` code around `5.times { ... }`, we would see the script run sequentially. This is because `async` can be utilized by non-async code, though not providing any performance benefits if not `async` aware (within a [`Async::Reactor`](https://github.com/socketry/async#reactors)).
