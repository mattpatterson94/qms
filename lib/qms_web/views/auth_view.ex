defmodule QmsWeb.AuthView do
  use QmsWeb, :view

  def render("create.json", params) do
    %{
      response_type: "ephemeral",
      text: "We need permission to use your Spotify.",
      attachments: [
        %{
          fallback: "<#{params[:url]}|Authenticate with Spotify>",
          actions: [
            %{
              type: "button",
              text: "Authenticate with Spotify",
              url: "#{params[:url]}"
            }
          ]
        }
      ]
    }
  end
end
