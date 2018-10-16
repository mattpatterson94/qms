defmodule QmsWeb.Router do
  use QmsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", QmsWeb do
    pipe_through :api

    resources "/auth", Api.AuthController, only: [:create]
    resources "/song", Api.SongController, only: [:create]
  end

  scope "/webhook", QmsWeb do
    pipe_through :api

    resources "/auth", Webhook.AuthController, only: [:index]
  end

  # Other scopes may use custom stacks.
  # scope "/api", QmsWeb do
  #   pipe_through :api
  # end
end
