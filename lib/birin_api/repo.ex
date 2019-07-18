defmodule BirinApi.Repo do
  use Ecto.Repo,
    otp_app: :birin_api,
    adapter: Ecto.Adapters.Postgres

  def init(_type, config) do
    case(config[:hostname]) do
      nil -> {:ok, Keyword.put(config, :url, System.get_env("DATABASE_URL"))}
      _ -> {:ok, config}
    end
  end
end
