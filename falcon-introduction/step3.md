Falcon is capable of streaming responses:

## Source Code

```ruby
def bottles(n)
	n == 1 ? "#{n} bottle" : "#{n} bottles"
end

# Browsers don't show streaming content until a certain threshold has been met. For most browers, it's about 1024 bytes. So, we have a comment of about that length which we feed to the client before streaming actual content. For more details see https://stackoverflow.com/questions/16909227
COMMENT = "<!--#{'-' * 1024}-->"

run lambda do |env|
	task = Async::Task.current
	body = Async::HTTP::Body::Writable.new
	
	count = 99
	
	body.write("<!DOCTYPE html><html><head><title>#{count} Bottles of Beer</title></head><body>")
	
	task.async do |task|
		body.write(COMMENT)
		
		count.downto(1) do |i|
			puts "#{bottles(i)} of beer on the wall..."
			body.write("<p>#{bottles(i)} of beer on the wall, ")
			task.sleep(0.1)
			body.write("#{bottles(i)} of beer, ")
			task.sleep(0.1)
			body.write("take one down and pass it around, ")
			task.sleep(0.1)
			body.write("#{bottles(i-1)} of beer on the wall.</p>")
			task.sleep(0.1)
			body.write("<script>var child; while (child = document.body.firstChild) child.remove();</script>")
		end
		
		code = File.read(__FILE__)
		body.write("<h1>Source Code</h1>")
		body.write("<pre><code>#{Trenni::Markup.escape_string code}</code></pre>")
		body.write("</body></html>")
	rescue
		puts "Remote end closed connection: #{$!}"
	ensure
		body.close
	end
end
```

## Run the server

Once we add the code to `config.ru`, we can run it:
`falcon serve --bind http://localhost:80`{{execute}}
