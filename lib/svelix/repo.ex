defmodule Svelix.Repo do
  use Ecto.Repo,
    otp_app: :svelix,
    adapter: Ecto.Adapters.Postgres
end
