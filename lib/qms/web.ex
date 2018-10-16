defmodule Qms.Web do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.spotify.com/v1/"
  plug Tesla.Middleware.JSON

  def get(access_token) do
    url = "/me/player/currently-playing"
    new_authorization_header = "Authorization: Basic #{access_token}"

    get(url)
  end
end
