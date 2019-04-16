Now that we have `falcon` installed, lets try writing a simple rack server (in `~/config.ru`):

## Source Code

```ruby
class App
	def call(env)
		return [200, [], ["Hello World"]]
	end
end

run App.new
```

## Run the server

Once we add the code to `config.ru`, we can run it:
`falcon serve --bind http://[::]:80`{{execute}}

You can open the application by [clicking this link](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/).

## Exit the server

To quit `falcon`, press `Ctrl-C` when focused on the terminal.
