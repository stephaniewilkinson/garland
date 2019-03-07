defmodule GarlandWeb.WishController do
  use GarlandWeb, :controller

  alias Garland.Accounts
  alias Garland.Accounts.Wish

  def index(conn, _params, _user) do
    wishes = Accounts.list_wishes()
    render(conn, "index.html", wishes: wishes)
  end

  def new(conn, _params, _user) do
    changeset = Accounts.change_wish(%Wish{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"wish" => wish_params}, _user) do
    case Accounts.create_wish(wish_params) do
      {:ok, wish} ->
        conn
        |> put_flash(:info, "Wish created successfully.")
        |> redirect(to: Routes.user_wish_path(conn, :show, wish))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, _user) do
    wish = Accounts.get_wish!(id)
    render(conn, "show.html", wish: wish)
  end

  def edit(conn, %{"id" => id}, _user) do
    wish = Accounts.get_wish!(id)
    changeset = Accounts.change_wish(wish)
    render(conn, "edit.html", wish: wish, changeset: changeset)
  end

  def update(conn, %{"id" => id, "wish" => wish_params}, _user) do
    wish = Accounts.get_wish!(id)

    case Accounts.update_wish(wish, wish_params) do
      {:ok, wish} ->
        conn
        |> put_flash(:info, "Wish updated successfully.")
        |> redirect(to: Routes.user_wish_path(conn, :show, wish))

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
