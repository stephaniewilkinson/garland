defmodule GarlandWeb.WishController do
  use GarlandWeb, :controller

  alias Garland.Accounts
  alias Garland.Accounts.Wish
  alias Phoenix.LiveView

  def action(conn, _) do
    user = Accounts.get_user!(conn.params["user_id"])
    args = [conn, conn.params, user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, user) do
    wishes = Accounts.list_wishes(user)
    render(conn, "index.html", user: user, wishes: wishes)
  end

  def new(conn, _params, user) do
    changeset = Accounts.change_wish(%Wish{})
    # render(conn, "new.html", changeset: changeset, user: user)
    LiveView.Controller.live_render(conn, GarlandWeb.WishFetcherView, session: %{})
  end

  def create(conn, %{"wish" => wish_params}, user) do
    wish_params =
      wish_params
      |> Map.put("user_id", user.id)

    case Accounts.create_wish(wish_params) do
      {:ok, wish} ->
        conn
        |> put_flash(:info, "Wish created successfully.")
        |> redirect(to: Routes.user_wish_path(conn, :show, user, wish))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, user: user)
    end
  end

  def show(conn, %{"id" => id}, user) do
    wish = Accounts.get_wish!(id)
    render(conn, "show.html", wish: wish, user: user)
  end

  def edit(conn, %{"id" => id}, user) do
    wish = Accounts.get_wish!(id)
    changeset = Accounts.change_wish(wish)
    render(conn, "edit.html", wish: wish, changeset: changeset, user: user)
  end

  def update(conn, %{"id" => id, "wish" => wish_params}, user) do
    wish = Accounts.get_wish!(id)

    case Accounts.update_wish(wish, wish_params) do
      {:ok, wish} ->
        conn
        |> put_flash(:info, "Wish updated successfully.")
        |> redirect(to: Routes.user_wish_path(conn, :show, user, wish))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", wish: wish, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    wish = Accounts.get_wish!(id)
    {:ok, _wish} = Accounts.delete_wish(wish)

    conn
    |> put_flash(:info, "Wish deleted successfully.")
    |> redirect(to: Routes.user_wish_path(conn, :index, user))
  end
end
