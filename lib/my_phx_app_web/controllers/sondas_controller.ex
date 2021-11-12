defmodule MyPhxAppWeb.SondasController do
use MyPhxAppWeb, :controller

alias MyPhxApp.Services.ActionSonda


  def startingPosition(conn, _) do
    ActionSonda.starting_position({:ok,  "ok"})
    ActionSonda.getPosition()
    |>response(conn)
  end

  def position(conn,_) do
    ActionSonda.getPosition()
    |>response(conn)

  end
  def moving(conn, request) do
    request
    |> MyPhxApp.moving()
    |> response(conn)
   end

   def response({:ok, reason}, conn) do
    conn
   |> put_status(200)
   |> json(reason)
  end

  def response({:error, reason}, conn) do
    conn
    |> put_status(400)
    |> json(%{erro: reason})
  end

end
