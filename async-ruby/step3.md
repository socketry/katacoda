Asynchronous tasks can take arbitrary amounts of time, and often we want to limit the execution time to a given timeout value.

We can adjust our previous `script.rb` to include a timeout of `0.5` seconds.

## Source Code

```ruby
require 'async'

# example function that takes a random ammount of time to complete
# now with a timeout
def example(id)
  Async do |task|
    task.with_timeout(0.5) do
      value = rand # get random value
      puts "Putting #{id} to sleep for #{value} seconds."
      task.sleep(value)
      puts "#{id} woke up!"
    end
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
`ruby script.rb`{{executr}}

Which will print something like:
```
ruby step3.rb 
Putting 0 to sleep for 0.799244934361936 seconds.
Putting 1 to sleep for 0.744209168995344 seconds.
Putting 2 to sleep for 0.4548160280128716 seconds.
Putting 3 to sleep for 0.7809507088811412 seconds.
Putting 4 to sleep for 0.641723410730038 seconds.
2 woke up!
0 timed out!
1 timed out!
3 timed out!
4 timed out!
```

Like before, each `example()` function is called in order, but now tasks with a timeout greater than `0.5` will not "wake up" from their sleep.
