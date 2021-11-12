defmodule MyPhxAppWeb.ActionSondaTest do
  use ExUnit.Case

  alias MyPhxApp.Services.ActionSonda
  alias MyPhxApp.Agents.SondaAgent

  test "Checking the function the probe movement through the terrain as a null value" do
    SondaAgent.start_link(%MyPhxApp.Structs.Sonda{orientation: "W", position: [1, 2]})
    assert ActionSonda.execute(nil) == %MyPhxApp.Structs.Sonda{orientation: "W", position: [1, 2]}
  end

  test "Checking the probe movement function across the terrain" do
    SondaAgent.start_link(%MyPhxApp.Structs.Sonda{orientation: "W", position: [1, 2]})
    ActionSonda.execute({:ok,["M"]})

    assert  SondaAgent.get == %MyPhxApp.Structs.Sonda{orientation: "W", position: [0, 2]}
  end

  test "Checking the start of the start position" do
    ActionSonda.starting_position({:ok,   "ok"})
    assert  SondaAgent.get == %MyPhxApp.Structs.Sonda{orientation: "E", position: [0, 0]}
  end



end
