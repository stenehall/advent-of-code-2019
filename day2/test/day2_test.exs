defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "test 1" do
    assert ([1, 0, 0, 0, 99]
      |> Day2.tick(0)) == [2,0,0,0,99]
  end

  test "test 2" do
    assert ([2,3,0,3,99]
      |> Day2.tick(0)) == [2,3,0,6,99]
  end

  test "test 3" do
    assert ([2,4,4,5,99,0]
      |> Day2.tick(0)) == [2,4,4,5,99,9801]
  end

  test "test 4" do
    assert ([1,1,1,4,99,5,6,0,99]
      |> Day2.tick(0)) == [30,1,1,4,2,5,6,0,99]
  end

  test "day 2 task 1" do
    assert Day2.task1(12, 2) == 3166704
  end
  
  test "day 2 task 2" do
    assert Day2.task2(19690720) == 8018
  end
end
