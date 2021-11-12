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
end
