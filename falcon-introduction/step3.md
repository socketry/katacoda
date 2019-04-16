Falcon is capable of streaming responses:

## Source Code

```ruby
class App
	# Browsers don't show streaming content until a certain threshold has been met. For most browsers, it's about 1024 bytes. So, we have a comment of about that length which we feed to the client before streaming actual content. For more details see https://stackoverflow.com/questions/16909227
	COMMENT = "<!--#{'-' * 1024}-->"
	
	def bottles(n)
		n == 1 ? "#{n} bottle" : "#{n} bottles"
	end
	
	def sing(task, body, count = 99)
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
	rescue
		puts "Remote end closed connection: #{$!}"
	ensure
		body.close
	end
	
	def call(env)
		task = Async::Task.current
		body = Async::HTTP::Body::Writable.new
		
		count = 99
		
		body.write("<!DOCTYPE html><html><head><title>#{count} Bottles of Beer</title></head><body>")
		
		task.async do |subtask|
			sing(subtask, body)
		end
		
		return [200, {'content-type' => 'text/html'}, body]
	end
end

run App.new
```

## Run the server

Once we add the code to `config.ru`, we can run it:
`falcon serve --bind http://[::]:80`{{execute}}

You can open the application by [clicking this link](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/).
