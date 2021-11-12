defmodule MyPhxApp.Services.ActionSonda do

  alias MyPhxApp.Agents.SondaAgent
  alias MyPhxApp.Structs.Sonda
  alias MyPhxApp.Services.MovingSonda
  alias MyPhxApp.Services.History
  alias MyPhxApp.Validations.ValidateMovement

  @bussola  %{
    :N => "C",
    :E => "D",
    :S => "B",
    :W => "E"
  }

  def call(params) do

    params
    |> ValidateMovement.changeset()
    |> starting_position()
    |> execute()
    |> response()
  end
  def execute(nil), do: SondaAgent.get()
  def execute({:ok, command}) do
   cond do
    Enum.count(command) == 0  -> {:ok, "Comandos executados"}
    Enum.count(command) >= 0 ->
      [head | tail] = command
      head
      |> MovingSonda.control(SondaAgent.get())
      |> checkMoving(tail)
      |> execute()
   end
  end
  def execute({:error, error}), do: {:error, error}

  def checkMoving({:error, error}, _), do:  {:error, error}
  def checkMoving(_, tail), do:  {:ok ,tail}

  def starting_position({:ok, struct}) do
    History.starting_history()

    Sonda.new()
    |> SondaAgent.start_link()
    |> checkAgent(struct)
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
