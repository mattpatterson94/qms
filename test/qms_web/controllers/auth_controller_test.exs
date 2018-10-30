defmodule QmsWeb.AuthControllerTest do
  use QmsWeb.ConnCase

  setup do
    Application.put_env(:qms, "SPOTIFY_REDIRECT_URI", "http://example.com")
    Application.put_env(:qms, "SPOTIFY_CLIENT_ID", "12345")
  end

  describe "create/2" do
    test "Returns a slack response which includes a button to authenticate user with Spotify", %{conn: conn} do
      expected_url = "https://accounts.spotify.com/authorize?response_type=code&client_id=12345&redirect_url=http://example.com"

      response =
        conn
        |> post(auth_path(conn, :create))
        |> json_response(200)

      expected = %{
        "response_type" => "ephemeral",
        "text" => "We need permission to use your Spotify.",
        "attachments" => [
          %{
            "fallback" => "<#{expected_url}|Authenticate with Spotify>",
            "actions" => [
              %{
                "type" => "button",
                "text" => "Authenticate with Spotify",
                "url" => "#{expected_url}"
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
