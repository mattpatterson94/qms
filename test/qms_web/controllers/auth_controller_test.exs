defmodule QmsWeb.AuthControllerTest do
  use QmsWeb.ConnCase

  setup do
    System.put_env("SPOTIFY_REDIRECT_URI", "http://example.com")
    System.put_env("SPOTIFY_CLIENT_ID", "12345")
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
      expected_url = "https://accounts.spotify.com/authorize?response_type=code&client_id=12345&state=#{expected_user.temp_auth_token}&redirect_uri=http://example.com"

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

    test "Does not return already authenticated if the user exists but does not have a valid status", %{conn: conn} do
      Qms.Repo.insert(%Qms.User{slack_user_id: "U2147483697", status: 0}, on_conflict: :nothing)

      request_params = %{
        user_id: "U2147483697",
        command: "/qmsauth",
        token: "gIkuvaNzQIHg97ATvDxqgjtO"
      }

      response =
        conn
        |> post(auth_path(conn, :create), request_params)
        |> json_response(200)

      not_expected = %{
        "response_type" => "ephemeral",
        "text" => "You are already authenticated.",
      }

      refute response == not_expected
    end

    test "Returns already authenticated if user exists and has a valid status", %{conn: conn} do
      Qms.Repo.insert(%Qms.User{slack_user_id: "U2147483697", status: 1}, on_conflict: :nothing)

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
