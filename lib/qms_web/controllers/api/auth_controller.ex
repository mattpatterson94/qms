defmodule QmsWeb.Api.AuthController do
  use QmsWeb, :controller
  alias Qms.{Repo, User}

  def create(conn, params) do
    # render conn, "show.json"
    spotify_url = "https://accounts.spotify.com/authorize"
    redirect_uri = "https://mattpatterson.localtunnel.me/webhook/auth"
    response_type = "code"
    client_id = "<client_id>"

    # User.registration_changeset(%User{}, params) |> Repo.insert()
    # render conn, "#{spotify_url}?response_type=#{response_type}&client_id=#{client_id}&redirect_uri=#{redirect_uri}"
    render conn, "create.json", url: "#{spotify_url}?response_type=#{response_type}&client_id=#{client_id}&redirect_uri=#{redirect_uri}"
    # redirect conn, external: "#{spotify_url}?response_type=#{response_type}&client_id=#{client_id}&redirect_uri=#{redirect_uri}"
  end
end
