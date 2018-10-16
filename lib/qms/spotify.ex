defmodule Qms.Spotify do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://accounts.spotify.com/api"
  plug Tesla.Middleware.JSON

  def get() do
    url = "/token"
    grant_type = "authorization_code"
    redirect_uri = "https://mattpatterson.localtunnel.net/webhook/auth"
    code = "<insert code here>"
    authorization_header = "Basic <auth>"

    { :ok, response } = post(url, "", headers: [{"Authorization", authorization_header}])
    access_token = response.body["access_token"]

    Qms.Web.get(access_token)
  end
end
