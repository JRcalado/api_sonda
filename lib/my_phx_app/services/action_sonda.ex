defmodule MyPhxApp.Services.ActionSonda do

  alias MyPhxApp.Agents.SondaAgent
  alias MyPhxApp.Structs.Sonda
  alias MyPhxApp.Services.MovingSonda

  def action(sonda, grid, command) do
      SondaAgent.start_link(sonda)
     # execute(command)
      SondaAgent.get()
  end

  def execute(nil), do: SondaAgent.get()

  def execute(command) do

    String.next_codepoint(command)
    |> Tuple.to_list
    |> List.first
    |> MyPhxApp.Services.MovingSonda.control(SondaAgent.get())

    String.next_codepoint(command)
    |> Tuple.to_list
    |> List.last
    |> check_tring
    |> execute()
  end

  def check_tring(str) do

    case String.length(str)  do
      0 -> nil
      _ -> str
    end
  end

  def starting_position() do
    Sonda.new()
    |> SondaAgent.start_link()
    |> checkAgent
  end

  def checkAgent({:ok, reason}) do
    SondaAgent.get()|>IO.inspect
  end

  def checkAgent({:error, {:already_started, reason}}) do
    Sonda.new([0, 0], "E")
    |> SondaAgent.set()
  end


end
