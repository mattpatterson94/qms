defmodule Qms.UserTest do
  use Qms.DataCase

  alias Qms.User

  @valid_attrs %{slack_user_id: "12345", status: 1}
  @invalid_attrs %{slack_user_id: nil, status: 2}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
