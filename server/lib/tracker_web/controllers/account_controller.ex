defmodule TrackerWeb.AccountController do
  use TrackerWeb, :controller
  alias Tracker.Account
  alias Tracker.Account.User

  plug Ueberauth

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    user_params = %{
      token: auth.credentials.token,
      email: auth.info.email
    }
    changeset = User.changeset(%User{}, user_params)

    case Account.insert_or_update_user(changeset) do
      {:ok, user} -> conn |> redirect external: "http://localhost:8080"
      {:error, _error} -> conn |> render(TrackerWeb.ErrorView, "500.json")
    end
  end


  def request(conn, params) do
  end

end