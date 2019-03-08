defmodule BirinApi.Repo do
  use Ecto.Repo,
    otp_app: :birin_api,
    adapter: Ecto.Adapters.Postgres
end
