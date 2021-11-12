defmodule MyPhxAppWeb.SondasController do
use MyPhxAppWeb, :controller
use PhoenixSwagger

alias MyPhxApp.Services.ActionSonda

swagger_path :index do
  post "/moving"
  description "API de envio de coordenadas para uma sonda"
  consumes "application/json"
  produces "application/json"
  parameter "Authorization", :header, :string, "", required: true
  parameters do
    request_body :body, Schema.ref(:Send), "corpo da requisição"
  end
  tag "Send"
  response 200, "Success"
  response 401, "Unauthorized"
end

def swagger_definitions do
  %{
    Data: swagger_schema do
      title "starting-position"
      description "Endpoint que envia a sonda para a posição inicial (0,0)"
    end,

    Moved: swagger_schema do
      title "moving"
      description "Endpoint receber o movimento da sonda"
      properties do
        method :string, "Metodo de envio. E-mail = 1 , Sms = 2  ", required: true
      end
      example %{
          "movimentos": ["GE","M","M"]
        }



    end,
    Batch: swagger_schema do
      title "position"
      description "Responde as coordenadas atuais x e y "

    end

  }
end
  def startingPosition(conn, _) do
    ActionSonda.starting_position({:ok,  "ok"})
    ActionSonda.getPosition()
    |>response(conn)
  end
  swagger_path :startingPosition do
    put "/api/starting-position"
    description "Endpoint que envia a sonda para a posição inicial (0,0) "
    consumes "application/json"
    produces "application/json"
    tag "Definir posição"
    response 200, "Ok"
    response 400, "Bad Request"
  end

  def position(conn,_) do
    ActionSonda.getPosition()
    |>response(conn)

  end
  swagger_path :position do
    get "/api/position"
    description "Responde as coordenadas atuais x e y  "
    consumes "application/json"
    produces "application/json"
    tag "Retornar posição"
    response 200, "Ok"
    response 400, "Bad Request"
end
  def moving(conn, request) do
    request
    |> MyPhxApp.moving()
    |> response(conn)
   end
   swagger_path :moving do
      post "/api/moving"
      description "Endpoint receber o movimento da sonda "
      consumes "application/json"
      produces "application/json"
      parameters do
        request_body :body, Schema.ref(:Moved), "corpo da requisição"
      end
      tag "Mover sonda"
      response 200, "Ok"
      response 400, "Bad Request"
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
