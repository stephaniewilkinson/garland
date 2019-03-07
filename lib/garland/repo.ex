defmodule Garland.Repo do
  use Ecto.Repo,
    otp_app: :garland,
    adapter: Ecto.Adapters.Postgres
end
