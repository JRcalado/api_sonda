defmodule MyPhxAppWeb.Router do
  use MyPhxAppWeb, :router

  pipeline :api do
    plug :accepts, ["json","text","html"]
  end

  scope "/api", MyPhxAppWeb do
    pipe_through :api
    put  "/starting-position", SondasController, :startingPosition
    post  "/moving", SondasController, :moving
    get  "/position", SondasController, :position

  end

  def swagger_info do
    %{
      schemes: ["http", "https"],
      info: %{
        version: "1.0",
        title: "Sonda Api",
        description: "API Documentation for Sonda API v1",
        termsOfService: "For private",
        contact: %{
          name: "Sonda API",
          site: "https://calado.dev"
        }
      },
      consumes: ["application/json"],
      produces: ["application/json"],

    }
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :my_phx_app,
      swagger_file: "swagger.json"
  end
end
