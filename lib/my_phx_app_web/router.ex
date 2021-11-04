defmodule MyPhxAppWeb.Router do
  use MyPhxAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MyPhxAppWeb do
    pipe_through :api
    put  "/starting-position", SondasController, :startingPosition
    post  "/moving", SondasController, :moving

  end
end
