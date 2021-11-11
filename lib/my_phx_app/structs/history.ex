defmodule MyPhxApp.Structs.History do
  defstruct text: nil, giro: nil, moved: nil, eixo: nil

  def new(text) do
      %__MODULE__{text: text}
  end
  @girou   "girou para"
  @moveu   "moveu"
  @eixo   "para o eixo"

  def update_text(history, text)do
      %__MODULE__{history | text: text}
  end

  def update_giro(history, giro)do
    %__MODULE__{history | giro: giro}
    update_moved(history, 0)
  end

  def update_moved(history, moved)do
    %__MODULE__{history | moved: moved}
  end

  def update_eixo(history, eixo)do
    %__MODULE__{history | eixo: eixo}
  end



end
