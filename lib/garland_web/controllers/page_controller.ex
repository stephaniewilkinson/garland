defmodule GarlandWeb.PageController do
  use GarlandWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
