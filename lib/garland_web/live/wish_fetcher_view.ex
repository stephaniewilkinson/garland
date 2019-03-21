defmodule GarlandWeb.WishFetcherView do
  use Phoenix.LiveView

  def render(assigns) do
    # render(conn, "new.html", changeset: changeset, user: user)

    GarlandWeb.WishView.render("new.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, example_value: "Ready!")}
  end


  def handle_event("preview_link", %{"user" => params}, socket) do
    changeset =
      socket.assigns.user
      |> Demo.Accounts.change_user(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end
end
