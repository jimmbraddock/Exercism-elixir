defmodule HelloWorld do
    def hello(name \\ "World") do
        "Hello, " <> name <> "!"
    end
end

IO.puts("1")
IO.puts(HelloWorld.hello)
