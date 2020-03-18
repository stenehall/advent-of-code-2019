defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "test 1" do
    assert ("R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83"
      |> Day3.tick(0)) == [2,0,0,0,99]
  end

end
