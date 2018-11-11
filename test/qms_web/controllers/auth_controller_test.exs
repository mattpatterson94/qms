defmodule QmsWeb.AuthControllerTest do
  use QmsWeb.ConnCase

  setup do
    Application.put_env(:qms, "SPOTIFY_REDIRECT_URI", "http://example.com?token=%auth_token%")
    Application.put_env(:qms, "SPOTIFY_CLIENT_ID", "12345")
  end

  describe "create/2" do
    test "Returns a slack response which includes a button to authenticate user with Spotify", %{conn: conn} do
      request_params = %{
        user_id: "U2147483697",
        command: "/qmsauth",
        token: "gIkuvaNzQIHg97ATvDxqgjtO"
      }

      response =
        conn
        |> post(auth_path(conn, :create), request_params)
        |> json_response(200)

      expected_user = Qms.Repo.get_by(Qms.User, slack_user_id: "U2147483697")
      expected_url = "https://accounts.spotify.com/authorize?response_type=code&client_id=12345&redirect_url=http://example.com?token=#{expected_user.temp_auth_token}"

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

    test "Persists user in database when request is made", %{conn: conn} do
      request_params = %{
        user_id: "U2147483697",
        command: "/qmsauth",
        token: "gIkuvaNzQIHg97ATvDxqgjtO"
      }

      conn
      |> post(auth_path(conn, :create), request_params)
      |> json_response(200)

      user = Qms.Repo.get_by(Qms.User, slack_user_id: "U2147483697")

      assert !!user == true
    end

    test "Returns an error response if not provided the correct details from Slack", %{conn: conn} do
      request_params = %{}

      response =
        conn
        |> post(auth_path(conn, :create), request_params)
        |> json_response(400)

      expected = %{
        "response_type" => "ephemeral",
        "text" => "There was an error with your call. Please try again later.",
      }

      assert response == expected
    end

    test "Returns already authenticated if user already has a valid authentication token", %{conn: conn} do
      Qms.Repo.insert(%Qms.User{slack_user_id: "U2147483697"}, on_conflict: :nothing)

      request_params = %{
        user_id: "U2147483697",
        command: "/qmsauth",
        token: "gIkuvaNzQIHg97ATvDxqgjtO"
      }

      response =
        conn
        |> post(auth_path(conn, :create), request_params)
        |> json_response(200)

      expected = %{
        "response_type" => "ephemeral",
        "text" => "You are already authenticated.",
      }

      assert response == expected
    end
  end
end
