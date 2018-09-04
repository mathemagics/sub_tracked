defmodule Tracker.AccountsTest do
  use Tracker.DataCase

  alias Tracker.Accounts

  describe "users" do
    alias Tracker.Accounts.User

    @valid_attrs %{age: 42, email: "some email", family_name: "some family_name", given_name: "some given_name", image: "some image", name: "some name", weight: 42}
    @update_attrs %{age: 43, email: "some updated email", family_name: "some updated family_name", given_name: "some updated given_name", image: "some updated image", name: "some updated name", weight: 43}
    @invalid_attrs %{age: nil, email: nil, family_name: nil, given_name: nil, image: nil, name: nil, weight: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.age == 42
      assert user.email == "some email"
      assert user.family_name == "some family_name"
      assert user.given_name == "some given_name"
      assert user.image == "some image"
      assert user.name == "some name"
      assert user.weight == 42
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.age == 43
      assert user.email == "some updated email"
      assert user.family_name == "some updated family_name"
      assert user.given_name == "some updated given_name"
      assert user.image == "some updated image"
      assert user.name == "some updated name"
      assert user.weight == 43
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
