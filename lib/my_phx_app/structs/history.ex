defmodule MyPhxApp.Structs.History do
  defstruct text: nil, giro: nil, position: [0,0], eixoX: 0,eixoY: 0

  def new(text) do
      %__MODULE__{text: text}
  end
  def new() do
    %__MODULE__{}
end
  @girou   "girou para"
  @moveu   "moveu"
  @eixo   "casas para o eixo"
  @position_map  %{
    :N => "cima",
    :E => "direita",
    :S => "baixo",
    :W => "esquerda"

  }


  def update_text(history, text)do
      %__MODULE__{history | text: text}
  end

  def update_orientation(history, giro)do

     gir = Map.get(@position_map, String.to_atom(giro))
     text =  "#{@girou} #{gir}"

     %__MODULE__{history | eixoX: 0}
     %__MODULE__{history | eixoY: 0}

     textMap = Map.get(%__MODULE__{}, :text)
     textFinal =  "#{history.text} #{textMap} #{text}"
     %__MODULE__{history | text: textFinal}

  end

  def update_position(history, position)do

    position_ant = Map.get(%__MODULE__{},:position)
    cond do
      List.first(position_ant) !== List.first(position) -> update_eixo_x(history,"eixoX")
      List.last(position_ant) !== List.last(position)   -> update_eixo_y(history,"eixoY")
      true -> true
    end
    %__MODULE__{history | position: position}
  end

  def update_eixo_x(history, eixo) do


    eixo_atom = String.to_atom(eixo)
    eixo_map = Map.get(%__MODULE__{},eixo_atom)
    eixo_new = eixo_map + 1

    %__MODULE__{history | eixoX: eixo_new}
  end

  def update_eixo_y(history, eixo) do
    eixo_atom = String.to_atom(eixo)
    eixo_map = Map.get(%__MODULE__{},eixo_atom)
    eixo_new = eixo_map + 1

    %__MODULE__{history | eixoY: eixo_new}
  end




end
