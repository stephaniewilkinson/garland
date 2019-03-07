defmodule Garland.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Garland.Repo

  alias Garland.Accounts.{User, Wish}

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    User
    |> Repo.get!(id)
    |> Repo.preload(:wishes)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:wishes, with: &Wish.changeset/2)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:wishes, with: &Wish.changeset/2)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Returns the list of wishes.

  ## Examples

      iex> list_wishes()
      [%Wish{}, ...]

  """
  def list_wishes do
    Repo.all(Wish)
  end

  @doc """
  Gets a single wish.

  Raises `Ecto.NoResultsError` if the Wish does not exist.

  ## Examples

      iex> get_wish!(123)
      %Wish{}

      iex> get_wish!(456)
      ** (Ecto.NoResultsError)

  """
  def get_wish!(id), do: Repo.get!(Wish, id)

  @doc """
  Creates a wish.

  ## Examples

      iex> create_wish(%{field: value})
      {:ok, %Wish{}}

      iex> create_wish(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_wish(attrs \\ %{}) do
    %Wish{}
    |> Wish.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a wish.

  ## Examples

      iex> update_wish(wish, %{field: new_value})
      {:ok, %Wish{}}

      iex> update_wish(wish, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_wish(%Wish{} = wish, attrs) do
    wish
    |> Wish.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Wish.

  ## Examples

      iex> delete_wish(wish)
      {:ok, %Wish{}}

      iex> delete_wish(wish)
      {:error, %Ecto.Changeset{}}

  """
  def delete_wish(%Wish{} = wish) do
    Repo.delete(wish)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking wish changes.

  ## Examples

      iex> change_wish(wish)
      %Ecto.Changeset{source: %Wish{}}

  """
  def change_wish(%Wish{} = wish) do
    Wish.changeset(wish, %{})
  end
end
