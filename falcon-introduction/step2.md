Now that we have `falcon` installed, lets try writing a simple rack server (in `~/config.ru`):

## Source Code

```ruby

run lambda do |env|
	[200, [], ["Hello World!"]]
end
```

## Run the server

Once we add the code to `config.ru`, we can run it:
`falcon serve --bind http://localhost:80`{{execute}}
