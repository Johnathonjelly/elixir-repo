defmodule Greeter do
  def greet do
    name = IO.gets("Hello, what is your name?\n")

    case String.trim(name) do
      "Johnathon" -> IO.puts("Wow! My name is #{String.trim(name)} too!\n")
      _ -> IO.puts("Nice to meet you, #{String.trim(name)}.\n")
    end
  end
end
