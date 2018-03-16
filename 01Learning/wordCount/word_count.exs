defmodule Count do
  @on_load :menu

  def menu do
    decision =
      IO.gets(
        "Count the number of words, characters, or lines in a document. Please enter \"words\", \"chars\", or \"lines\".\n "
      )

    case String.trim(decision) do
      "words" ->
        filename = IO.gets("Type filename for word counting: \n") |> String.trim()
        body = File.read!(filename)

        count =
          String.split(body, ~r{(\\n|[^\w'])+})
          |> Enum.filter(fn x -> x != "" end)
          |> Enum.count()

        IO.inspect(count)

      "chars" ->
        filename = IO.gets("Type filename for char counting: \n") |> String.trim()
        body = File.read!(filename)

        count =
          String.split(body, ~r{[a-zA-Z/g]})
          |> Enum.count()

        IO.inspect(count)

      "lines" ->
        filename = IO.gets("Type filename for word counting: \n") |> String.trim()
        body = File.read!(filename)

        count =
          String.split(body, ~r{(\r\n|\n|\r)})
          |> Enum.count()

        IO.inspect(count)
    end
  end
end
