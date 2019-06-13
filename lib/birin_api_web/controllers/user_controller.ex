defmodule BirinApiWeb.UserController do
  use BirinApiWeb, :controller
  require Logger

  alias BirinApi.Accounts
  alias BirinApi.Accounts.User
  alias BirinApi.Import

  action_fallback(BirinApiWeb.FallbackController)

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def import(conn, %{"users_file" => users_file = %Plug.Upload{}}) do
    extension = Path.extname(users_file.filename)
    users_stream = file_stream(users_file.path, extension)

    Task.async(fn ->
      amount_created = import_stream(users_stream)

      Logger.info("Imported #{amount_created} user records")
    end)

    conn
    |> json(%{"importing" => %{source: extension, count: users_stream |> Enum.count()}})
  end

  defp file_stream(filepath, ".csv") do
    filepath
    |> Import.Users.from_csv_file()
  end

  defp import_stream(users_stream) do
    {:ok, amount_created} = Accounts.create_users(users_stream)

    amount_created
  end
end
