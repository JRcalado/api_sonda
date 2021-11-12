defmodule MyPhxAppWeb.PlanaltoTest do
  use ExUnit.Case

  alias MyPhxApp.Structs.Planalto

  test "Testing for movement outside the terrain boundaries" do
    assert Planalto.chickLimits([5, 1]) == false
  end

  test "Testing movement within terrain boundaries" do
    assert Planalto.chickLimits([0, 1]) == true
  end

  test "Testing movement within terrain boundaries in negative position" do
    assert Planalto.chickLimits([0, -1]) == false
  end

end
