defmodule MyPhxApp.Services.MovingSonda do

  alias MyPhxApp.Agents.SondaAgent
  alias MyPhxApp.Structs.Sonda
  alias MyPhxApp.Structs.Planalto
  alias MyPhxApp.Services.History

  @map  %{
    :N => %{GE: "W", GD: "E"},
    :E =>%{GE: "N", GD: "S"},
    :S => %{GE: "E", GD: "W"},
    :W => %{GE: "S", GD: "N"}
  }


  def control(out, sonda)do
   action = String.upcase(out)
   cond do
     action == "GE" or action == "GD" -> calculate(action,  sonda.orientation) |>  updade_orientatio()
     action == "M" -> moved( sonda.position,  sonda.orientation) |> checkLimis |> updade_position()
     true -> {:error, "coordenadas erradas"}

   end

 end

 def checkLimis(locations) do

    cond do
      Planalto.chickLimits(locations) == false ->  {:error, "Os limites do planalto foram exedidos, enviar coordenadas dentro de 5x5 "}
      true -> {:ok, locations}
    end
 end

def moved(position, orientation)do
   case  String.upcase(orientation) do
     "N" -> List.update_at(position, 1, &(&1 + 1))
     "E" -> List.update_at(position, 0, &(&1 + 1))
     "S" -> List.update_at(position, 1, &(&1 - 1))
     "W" -> List.update_at(position, 0, &(&1 - 1))
   end

end

def calculate(turn, orientation )do
   Map.get(@map, String.upcase(orientation) |> String.to_atom())
   |> Map.get( String.to_atom(turn))
end

 def updade_orientatio(orientation) do
  History.update_orientation(orientation)
  SondaAgent.get()
  |> Sonda.update_orientation(orientation)
  |> SondaAgent.set()

  SondaAgent.get()
end

def updade_position({:ok, position}) do
  History.update_position(position)
  SondaAgent.get()
  |> Sonda.update_position(position)
  |> SondaAgent.set()
end

def updade_position( {:error, error}), do:  {:error , error}

end
