defmodule Day2 do
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
    action = Day2.get(memory, pointer)
    noun = Day2.get(memory, Day2.get(memory, pointer + 1))
    verb = Day2.get(memory, Day2.get(memory, pointer + 2))
    output = Day2.get(memory, pointer + 3)

    case action do
      1 -> memory |> List.replace_at(output, noun + verb) |> Day2.tick(pointer + 4)
      2 -> memory |> List.replace_at(output, noun * verb) |> Day2.tick(pointer + 4)
      99 -> memory
      _ -> raise "Unknown action"
    end
  end

  @spec task1(noun, verb) :: integer
  def task1(noun, verb) do
    Day2.load()
    |> Day2.prepare(noun, verb)
    |> Day2.tick(0)
    |> List.first()
  end

  @spec task2(integer) :: integer
  def task2(search) do
    for noun <- 1..99,
        verb <- 1..99,
        task1(noun, verb) == search do
      100 * noun + verb
    end
    |> List.first()
  end
end
