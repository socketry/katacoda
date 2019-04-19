Now that we have `async-http` installed, lets try writing a simple script (in `~/script.rb`):

## Source Code

```ruby
require 'async'
require 'async/http/internet'

Async do
	internet = Async::HTTP::Internet.new

	response = internet.get("https://www.google.com/search?q=kittens")

	count = response.read.scan(/kitten/).count

	puts "#{count} kittens found."
ensure
	internet.close
end
```

This example performs a Google search using HTTP/2 and counts the number of times the keyword is found in the resulting HTML text.

## Run the Script

Once we add the code to `script.rb`, we can run it:
`ruby script.rb`{{execute}}

Which will print something like:
```
127 kittens found.
```
