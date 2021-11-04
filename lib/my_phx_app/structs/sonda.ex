defmodule MyPhxApp.Structs.Sonda do

  defstruct position: nil, orientation: nil

  def new(position, orientation) do
      %__MODULE__{position: position, orientation: orientation}
  end

  def new() do
    %__MODULE__{position: [0, 0], orientation:  "E"}
  end

  def update_position(sonda, position)do
      %__MODULE__{sonda | position: position}
  end

  def update_orientation(sonda, orientation)do
      %__MODULE__{sonda | orientation: orientation}
  end


end
