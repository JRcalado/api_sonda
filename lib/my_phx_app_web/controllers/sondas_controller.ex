defmodule MyPhxAppWeb.SondasController do
use MyPhxAppWeb, :controller

alias MyPhxApp.Services.ActionSonda
  def startingPosition(conn, request) do
   ActionSonda.starting_position
    conn
    |> put_status(200)
    |> json("Sucesso")
  end

  def moving(conn, request) do

    request
    |> MyPhxApp.moving()

    # ActionSonda.execute("M") |> IO.inspect()

    conn
     |> put_status(200)
     |> json("Sucesso")
   end

end
