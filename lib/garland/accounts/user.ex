defmodule Garland.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Garland.Accounts.Wish

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :picture, :string
    has_many :wishes, Wish

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :picture])
    |> validate_required([:first_name, :last_name, :email, :picture])
  end
end
