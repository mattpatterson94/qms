defmodule QmsWeb.AuthControllerTest do
  use QmsWeb.ConnCase

  describe "create/2" do
    test "Returns a slack response which includes a button to authenticate user with Spotify", %{conn: conn} do
      response =
        conn
        |> post(auth_path(conn, :create))
        |> json_response(200)

      expected = %{
        "response_type" => "ephemeral",
        "text" => "We need permission to use your Spotify.",
        "attachments" => [
          %{
            "fallback" => "<http://example.com|Authenticate with Spotify>",
            "actions" => [
              %{
                "type" => "button",
                "text" => "Authenticate with Spotify",
                "url" => "http://example.com"
              }
            ]
          }
        ]
      }

      assert response == expected
    end

    test "Returns already authenticated if user has valid authentication token", %{conn: conn} do
      Qms.Repo.insert(%Qms.User{slack_user_id: "12345"}, on_conflict: :nothing)

      response =
        conn
        |> post(auth_path(conn, :create))
        |> json_response(200)

      expected = %{
        response_type: "ephemeral",
        text: "You are already authenticated.",
      }

      assert response == expected
    end
  end
end
