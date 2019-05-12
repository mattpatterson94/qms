defmodule QmsWeb.Router do
  use QmsWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/webhook", QmsWeb do
    pipe_through(:browser)

    resources("/auth", Webhook.AuthController, only: [:index])
  end

  scope "/api", QmsWeb do
    pipe_through(:api)

    resources("/song", Api.SongController, only: [:create])
  end
end
