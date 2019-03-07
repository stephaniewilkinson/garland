defmodule Garland.AccountsTest do
  use Garland.DataCase

  alias Garland.Accounts

  describe "users" do
    alias Garland.Accounts.User

    @valid_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name", picture: "some picture"}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", picture: "some updated picture"}
    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, picture: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.picture == "some picture"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.picture == "some updated picture"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "wishes" do
    alias Garland.Accounts.Wish

    @valid_attrs %{bought: true, image: "some image", note: "some note", quantity: 42, title: "some title", url: "some url"}
    @update_attrs %{bought: false, image: "some updated image", note: "some updated note", quantity: 43, title: "some updated title", url: "some updated url"}
    @invalid_attrs %{bought: nil, image: nil, note: nil, quantity: nil, title: nil, url: nil}

    def wish_fixture(attrs \\ %{}) do
      {:ok, wish} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_wish()

      wish
    end

    test "list_wishes/0 returns all wishes" do
      wish = wish_fixture()
      assert Accounts.list_wishes() == [wish]
    end

    test "get_wish!/1 returns the wish with given id" do
      wish = wish_fixture()
      assert Accounts.get_wish!(wish.id) == wish
    end

    test "create_wish/1 with valid data creates a wish" do
      assert {:ok, %Wish{} = wish} = Accounts.create_wish(@valid_attrs)
      assert wish.bought == true
      assert wish.image == "some image"
      assert wish.note == "some note"
      assert wish.quantity == 42
      assert wish.title == "some title"
      assert wish.url == "some url"
    end

    test "create_wish/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_wish(@invalid_attrs)
    end

    test "update_wish/2 with valid data updates the wish" do
      wish = wish_fixture()
      assert {:ok, %Wish{} = wish} = Accounts.update_wish(wish, @update_attrs)
      assert wish.bought == false
      assert wish.image == "some updated image"
      assert wish.note == "some updated note"
      assert wish.quantity == 43
      assert wish.title == "some updated title"
      assert wish.url == "some updated url"
    end

    test "update_wish/2 with invalid data returns error changeset" do
      wish = wish_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_wish(wish, @invalid_attrs)
      assert wish == Accounts.get_wish!(wish.id)
    end

    test "delete_wish/1 deletes the wish" do
      wish = wish_fixture()
      assert {:ok, %Wish{}} = Accounts.delete_wish(wish)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_wish!(wish.id) end
    end

    test "change_wish/1 returns a wish changeset" do
      wish = wish_fixture()
      assert %Ecto.Changeset{} = Accounts.change_wish(wish)
    end
  end
end
