defmodule MyPhxApp.Services.ActionSonda do

  alias MyPhxApp.Agents.SondaAgent
  alias MyPhxApp.Structs.Sonda
  alias MyPhxApp.Services.MovingSonda
  alias MyPhxApp.Validations.ValidateMovement


  def call(params) do

    starting_position({:ok,  "ok"})
    SondaAgent.get()|> IO.inspect()


    params
    |> ValidateMovement.changeset()
    |> starting_position()
    |> execute()


    SondaAgent.get()|> IO.inspect()

  end

  def action(sonda, grid, command) do
      SondaAgent.start_link(sonda)
     # execute(command)
      SondaAgent.get()
  end

  def execute(nil), do: SondaAgent.get()

  def execute({:ok, command}) do

    IO.inspect(command)


   cond do
    Enum.count(command) == 0  -> {:ok, "Comandos executados"}
    Enum.count(command) >= 0 ->
      [head | tail] = command
      head
      |> MovingSonda.control(SondaAgent.get())
      execute({:ok, tail})
   end



  end
  def execute({:error, error}), do: {:error, error}
  # def check_tring(str) do

  #   case String.length(str)  do
  #     0 -> nil
  #     _ -> str
  #   end
  # end

  def starting_position({:ok, struct}) do
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


end
