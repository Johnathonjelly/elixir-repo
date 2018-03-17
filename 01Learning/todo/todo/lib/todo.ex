defmodule Todo do
  # ask user for filename
  # open file and read
  # parse data
  # ask user for command
  # read, write, add, load file, save file
  def start do
    filename = IO.gets("Select .csv from which to read todo from:\n") |> String.trim()

    read(filename)
    |> parse
    |> get_commands
  end

  def get_commands(data) do
    prompt =
      "\nType the first letter of the command you'd like to run.\n\n" <>
        "R)ead Todos     A)dd a Todo    D)elete a Todo    L)oad a .csv    S)ave a .csv    Q)uit\n\r\n"

    command = IO.gets(prompt) |> String.trim() |> String.downcase()

    case command do
      "r" -> show_todos(data)
      "d" -> delete_todos(data)
      "q" -> "Goodbye!"
      _ -> get_commands(data)
    end
  end

  def delete_todos(data) do
    todo = IO.gets("Which todo would you like to delete?\n") |> String.trim()

    if Map.has_key?(data, todo) do
      IO.puts("OK.\n")
      new_map = Map.drop(data, [todo])
      IO.puts(~s("#{todo}" has been deleted.\n))
      get_commands(new_map)
    else
      IO.puts("There is no todo named \"#{todo}\"\n")
      show_todos(data, false)
      delete_todos(data)
    end
  end

  def read(filename) do
    case File.read(filename) do
      {:ok, body} ->
        body

      {:error, reason} ->
        IO.puts(~s(Could not open file "#{filename}".\n ERROR: #{:file.format_error(reason)}\n))
        start()
    end
  end

  def parse(body) do
    [header | lines] = String.split(body, ~r{(\r\n|\r|\n)})
    titles = tl(String.split(header, ","))
    parse_lines(lines, titles)
  end

  def parse_lines(lines, titles) do
    Enum.reduce(lines, %{}, fn line, built ->
      [name | fields] = String.split(line, ",")

      if Enum.count(fields) == Enum.count(titles) do
        line_data = Enum.zip(titles, fields) |> Enum.into(%{})
        Map.merge(built, %{name => line_data})
      else
        built
      end
    end)
  end

  def show_todos(data, next_command? \\ true) do
    items = Map.keys(data)
    IO.puts("You have the following todos:\n")
    Enum.each(items, fn item -> IO.puts(item) end)
    IO.puts("\n")

    if next_command? do
      get_commands(data)
    end
  end
end
