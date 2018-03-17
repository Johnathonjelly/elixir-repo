defmodule Todo do
  # ask user for filename
  # open file and read
  # parse data
  # ask user for command
  # read, write, add, load file, save file
  def start do
    filename = IO.gets("Select .csv from which to read todo from:\n") |> String.trim()
    read(filename)
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
    lines = String.split(body, ~r{(\r\n|\r|\n)})
  end
end
