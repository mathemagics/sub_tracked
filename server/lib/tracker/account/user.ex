defmodule Tracker.Account.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :age, :integer
    field :email, :string
    field :family_name, :string
    field :given_name, :string
    field :image, :string
    field :name, :string
    field :weight, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :email, :family_name, :given_name, :age, :weight, :image])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end
end
