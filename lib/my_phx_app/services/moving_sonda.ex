defmodule MyPhxApp.Services.MovingSonda do

  alias MyPhxApp.Agents.SondaAgent
  alias MyPhxApp.Structs.Sonda



  def control(out, sonda)do

    action = String.upcase(out)
   cond do
     action == "L" or action == "R" -> calculate(action,  sonda.orientation) |> updade_orientatio()
     action == "M" -> moved( sonda.position,  sonda.orientation)|> updade_position()
     true -> {:error, "coordenadas erradas"}

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
#IO.inspect( "passei aqui")
              map =  %{
                  :N => %{L: "W", R: "E"},
                  :E =>%{L: "N", R: "S"},
                  :S => %{L: "E", R: "W"},
                  :W => %{L: "S", R: "N"}
               }
   Map.get(map, String.upcase(orientation) |> String.to_atom())
   |> Map.get( String.to_atom(turn))

 end

 def updade_orientatio(orientation) do
  SondaAgent.get()
  |> Sonda.update_orientation(orientation)
  |> SondaAgent.set()

  SondaAgent.get() |> IO.inspect()
end

def updade_position(position) do
  SondaAgent.get()
  |> Sonda.update_position(position)
  |> SondaAgent.set()
end

def updade_position( {:error, reason} =  error), do:  %{"error" => reason}

end
