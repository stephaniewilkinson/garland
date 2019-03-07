defmodule GarlandWeb.WishControllerTest do
  use GarlandWeb.ConnCase

  alias Garland.Accounts

  @create_attrs %{bought: true, image: "some image", note: "some note", quantity: 42, title: "some title", url: "some url"}
  @update_attrs %{bought: false, image: "some updated image", note: "some updated note", quantity: 43, title: "some updated title", url: "some updated url"}
  @invalid_attrs %{bought: nil, image: nil, note: nil, quantity: nil, title: nil, url: nil}

  def fixture(:wish) do
    {:ok, wish} = Accounts.create_wish(@create_attrs)
    wish
  end

  describe "index" do
    test "lists all wishes", %{conn: conn} do
      conn = get(conn, Routes.wish_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Wishes"
    end
  end

  describe "new wish" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.wish_path(conn, :new))
      assert html_response(conn, 200) =~ "New Wish"
    end
  end

  describe "create wish" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.wish_path(conn, :create), wish: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.wish_path(conn, :show, id)

      conn = get(conn, Routes.wish_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Wish"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.wish_path(conn, :create), wish: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Wish"
    end
  end

  describe "edit wish" do
    setup [:create_wish]

    test "renders form for editing chosen wish", %{conn: conn, wish: wish} do
      conn = get(conn, Routes.wish_path(conn, :edit, wish))
      assert html_response(conn, 200) =~ "Edit Wish"
    end
  end

  describe "update wish" do
    setup [:create_wish]

    test "redirects when data is valid", %{conn: conn, wish: wish} do
      conn = put(conn, Routes.wish_path(conn, :update, wish), wish: @update_attrs)
      assert redirected_to(conn) == Routes.wish_path(conn, :show, wish)

      conn = get(conn, Routes.wish_path(conn, :show, wish))
      assert html_response(conn, 200) =~ "some updated image"
    end

    test "renders errors when data is invalid", %{conn: conn, wish: wish} do
      conn = put(conn, Routes.wish_path(conn, :update, wish), wish: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Wish"
    end
  end

  describe "delete wish" do
    setup [:create_wish]

    test "deletes chosen wish", %{conn: conn, wish: wish} do
      conn = delete(conn, Routes.wish_path(conn, :delete, wish))
      assert redirected_to(conn) == Routes.wish_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.wish_path(conn, :show, wish))
      end
    end
  end

  defp create_wish(_) do
    wish = fixture(:wish)
    {:ok, wish: wish}
  end
end
