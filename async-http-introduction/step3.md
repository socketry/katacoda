Let's run several requests concurrently.

## Source Code

```ruby
require 'async'
require 'async/http/internet'

keywords = ["kitten", "doggie", "chicken"]

Async do
	internet = Async::HTTP::Internet.new
	
	keywords.map do |keyword|
		Async do
			response = internet.get("https://www.google.com/search?q=#{keyword}")
			
			count = response.read.scan(keyword).count
			
			puts "#{count} #{keyword.inspect} found."
		end
	end.each(&:wait)
ensure
	internet.close
end
```

We use a nested async block to indicate this code should run concurrently. We
invoke wait, to ensure all requests are finished before closing the connection.

## Run the Script

Once we add the code to `script.rb`, we can run it:
`ruby script.rb`{{execute}}

Which will print something like:
```
122 "kitten" found.
117 "doggie" found.
126 "chicken" found.
```

If you want to see what is happening in more detail, you can run it like this:
`CONSOLE_LOG_LEVEL=debug ruby script.rb`{{execute}}
