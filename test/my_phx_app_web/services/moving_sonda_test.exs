defmodule MyPhxAppWeb.MovingSondaTest do
  use ExUnit.Case
  alias MyPhxApp.Services.MovingSonda
  alias MyPhxApp.Agents.SondaAgent

  test "Checking for correct probe move ments" do
    SondaAgent.start_link(%MyPhxApp.Structs.Sonda{orientation: "W", position: [1, 2]})
    sonda =  SondaAgent.get()
    assert MovingSonda.control("m", sonda) == %MyPhxApp.Structs.Sonda{orientation: "W", position: [0, 2]}
  end

  test "test moving east " do
    assert MovingSonda.moved([1, 2], "E") == [2, 2]
  end

  test "test moving west " do
    assert MovingSonda.moved([1, 2], "W") == [0, 2]
  end

  test "test moving north " do
    assert MovingSonda.moved([1, 2], "N") == [1, 3]
  end

  test "test moving south " do
    assert MovingSonda.moved([1, 2], "S") == [1, 1]
  end

  test "test calculus test to come left" do
    assert MovingSonda.calculate("GE", "S") == "E"
  end

  test "test calculus test to come right" do
    assert MovingSonda.calculate("GD", "S") == "W"
  end

  test "test update orientation in struct" do
    SondaAgent.start_link(%MyPhxApp.Structs.Sonda{orientation: "W", position: [1, 2]})
    assert MovingSonda.updade_orientatio("N") == %MyPhxApp.Structs.Sonda{orientation: "N", position: [1, 2]}
  end

  test "test update position in struct" do
    SondaAgent.start_link(%MyPhxApp.Structs.Sonda{orientation: "W", position: [1, 2]})
    assert MovingSonda.updade_position({:ok,[1, 3]}) ==  %MyPhxApp.Structs.Sonda{orientation: "W", position: [1, 3]}
  end



end
