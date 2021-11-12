defmodule MyPhxApp.Structs.Planalto do

  defstruct size: [5,5], grid: nil

  def chickLimits(position) do

    [head | tail] = position
     size = Map.get(%__MODULE__{}, :size)
     cond do
       head === List.first(size) ->  false
       List.first(tail) === List.last(size) -> false
       head < 0 -> false
       List.first(tail) < 0 -> false
       tail != List.last(size)  -> true
     end


  end

end
