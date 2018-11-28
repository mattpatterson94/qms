defmodule QmsWeb.WebHook.AuthControllerTest do
  use QmsWeb.ConnCase

  setup do
    System.put_env("SPOTIFY_REDIRECT_URI", "http://example.com")
    System.put_env("SPOTIFY_CLIENT_ID", "12345")
    System.put_env("SPOTIFY_CLIENT_SECRET", "12345")
  end

  describe "index/2" do
    test "Returns user authenticated when a valid code and state is given", %{conn: conn} do
      request_params = %{
        code: "adb2d7d70797e27dd7ec9b289ce43e643d388d48",
        state: "ad3b8d70-9510-4be1-bc65-469f6f280229"
      }

      response =
        conn
        |> get(auth_path(conn, :index), request_params)
        |> json_response(200)

      IO.inspect response
    end

    # test "Returns user not found when an invalid state is given", %{conn: conn} do
    # end
      # request_params = %{
      #   user_id: "U2147483697",
      #   command: "/qmsauth",
      #   token: "gIkuvaNzQIHg97ATvDxqgjtO"
      # }

      # response =
      #   conn
      #   |> post(auth_path(conn, :create), request_params)
      #   |> json_response(200)

      # expected_user = Qms.Repo.get_by(Qms.User, slack_user_id: "U2147483697")
      # expected_url = "https://accounts.spotify.com/authorize?client_id=12345&redirect_uri=http://example.com&response_type=code&scope=user-read-currently-playing&state=#{expected_user.temp_auth_token}"

      # expected = %{
      #   "response_type" => "ephemeral",
      #   "text" => "We need permission to use your Spotify.",
      #   "attachments" => [
      #     %{
      #       "fallback" => "<#{expected_url}|Authenticate with Spotify>",
      #       "actions" => [
      #         %{
      #           "type" => "button",
      #           "text" => "Authenticate with Spotify",
      #           "url" => "#{expected_url}"
      #         }
      #       ]
      #     }
      #   ]
      # }

      # assert response == expected
    # end
  end
end
