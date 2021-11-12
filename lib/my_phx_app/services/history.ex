defmodule MyPhxApp.Services.History do

  alias MyPhxApp.Agents.SondaAgent
  alias MyPhxApp.Agents.HistoryAgent
  alias MyPhxApp.Structs.History


  def starting_history() do

    History.new()
    |> HistoryAgent.start_link()
    HistoryAgent.get()
  end


  def update_orientation(orientation) do
    HistoryAgent.get()
    |> History.update_orientation(orientation)
    |> HistoryAgent.set()

    # HistoryAgent.get() |> IO.inspect()
  end

  def update_position(position) do
    HistoryAgent.get()
    |> History.update_position(position)
    |> HistoryAgent.set()

    HistoryAgent.get() |> IO.inspect()
  end

  def starting_position({:error, error}), do: {:error, error}

  def checkAgent({:ok, _}, struct), do: {:ok, struct}
  def checkAgent({:error, {:already_started, _}}, struct) do
    Sonda.new([0, 0], "E")
    |> SondaAgent.set()
    {:ok, struct}

  end

  def checkAgent({:error, error}, _), do: {:error, error}

  def starting_history()do
    History.new()
    |> HistoryAgent.start_link()
  end

  def response({:ok, _}) do
    sonda = SondaAgent.get()
      {:ok ,%{
          x: List.first(sonda.position),
          y: List.last(sonda.position)
        }
      }
  end
  def response({:error, error}), do: {:error, error}

  def getPosition() do
    Sonda.new() |> SondaAgent.start_link()

    sonda = SondaAgent.get()

    orientation = @bussola
    |> Map.get(String.to_atom(sonda.orientation))

    {:ok ,%{
        x: List.first(sonda.position),
        y: List.last(sonda.position),
        face: orientation
      }
    }


  end


end
