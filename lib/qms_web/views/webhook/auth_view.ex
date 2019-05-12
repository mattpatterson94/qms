defmodule QmsWeb.Webhook.AuthView do
  use QmsWeb, :view

  def status(type) do
    case type do
      :success ->
        "You are now authenticated"

      _ ->
        "User not found"
    end
  end
end
