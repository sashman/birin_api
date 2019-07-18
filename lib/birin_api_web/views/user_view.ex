defmodule BirinApiWeb.UserView do
  use BirinApiWeb, :view
  alias BirinApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}), do: render_user(user)

  def render_user(user) do
    %{
      id: user.id,
      auth_id: user.auth_id,
      email: user.email,
      name: user.name,
      license_number: user.license_number,
      initials: user.initials
    }
  end
end
