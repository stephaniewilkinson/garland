defmodule Garland.Accounts.Wish do
  use Ecto.Schema
  import Ecto.Changeset
  alias Garland.Accounts.User

  schema "wishes" do
    field :bought, :boolean, default: false
    field :image, :string
    field :note, :string
    field :quantity, :integer
    field :title, :string
    field :url, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(wish, attrs) do
    wish
    |> cast(attrs, [:image, :note, :quantity, :title, :url, :bought, :user_id])
    |> validate_required([:image, :note, :quantity, :title, :url, :bought, :user_id])
  end
end
