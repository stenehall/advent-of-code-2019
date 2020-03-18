defmodule Day3 do
  @moduledoc """
  Day 2 of Advent of Code 2019.
  An attempt to learn Elixir.
  """

  @type address :: integer
  @type noun :: integer
  @type verb :: integer
  @type memory :: %{address => integer}

  @spec load() :: memory
  def load() do
    {:ok, memory} = File.read('2.data')

    memory
    |> String.replace("\n", "")
    |> String.split(",", trim: true)
    |> Enum.map(fn x -> String.to_integer(x) end)
  end

  @spec get(memory, integer) :: integer
  def get(memory, pointer) do
    Enum.at(memory, pointer, 0)
  end

  @spec prepare(memory, noun, verb) :: memory
  def prepare(memory, noun, verb) do
    memory
    |> List.replace_at(1, noun)
    |> List.replace_at(2, verb)
  end

  @spec tick(memory, integer) :: memory
  def tick(memory, pointer) do
    action = Day3.get(memory, pointer)
    noun = Day3.get(memory, Day3.get(memory, pointer + 1))
    verb = Day3.get(memory, Day3.get(memory, pointer + 2))
    output = Day3.get(memory, pointer + 3)

    case action do
      1 -> memory |> List.replace_at(output, (noun + verb)) |> Day3.tick(pointer + 4)
      2 -> memory |> List.replace_at(output, (noun * verb)) |> Day3.tick(pointer + 4)
      99 -> memory
      _ -> raise "Unknown action"
    end
  end

  def task1() do
    Day3.load()
    |> Day3.prepare(12, 2)
    |> Day3.tick(0)
    |> List.first()
  end

  def task2(search) do
    memory = Day3.load()

    (for noun <- 1..99, verb <- 1..99, do: 
      (result = memory
        |> Day3.prepare(noun, verb)
        |> Day3.tick(0)
        |> List.first

      if (result == search) do
        noun*100 + verb
      else 
        0
      end)) |> Enum.filter(fn x -> x != 0 end) |> List.first


    # Enum.map(1..99, fn noun ->
    #   Enum.map(1..99, fn verb ->
    #     result = memory
    #       |> Day3.prepare(noun, verb)
    #       |> Day3.tick(0)
    #       |> List.first
  
    #       if (result == search) do 
    #         noun*100 + verb
    #       else
    #         0
    #       end
    #   end)
    # end)
  end
end