defmodule GarlandWeb.Router do
  use GarlandWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GarlandWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/users", UserController do
      resources "/wishes", WishController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", GarlandWeb do
  #   pipe_through :api
  # end
end
