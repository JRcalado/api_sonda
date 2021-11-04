defmodule MyPhxApp.Structs.Planalto do

  defstruct size: nil, grid: nil

  def new(size) do
    %__MODULE__{
      size: sum(size), grid: init(size) |> Enum.reverse

    }
  end

  def init(size) do
    teste =  for x <- 0..List.first(size) do
      x
     end

     for x <- 1..List.last(size) do
      out = testeL(List.first(teste) + (x - 1), List.last(teste) + (x - 1)) |> List.to_tuple
     end

  end

  def testeL(first, last) do
    teste = for x <- first..last, do: x
  end

  def sum([]), do: 0

  def sum([head | tail]) do
    head + sum(tail)
  end

end
