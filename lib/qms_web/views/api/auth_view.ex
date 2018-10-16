defmodule QmsWeb.Api.AuthView do
  use QmsWeb, :view

  def render("update.json", _params) do
    %{
      response_type: "ephemeral",
      text: "Your Spotify account has been successfully connected to *QMS* :tada:",
      attachments: [
        %{
          text: "Use `/qms` to start sharing your tracks!"
        }
      ]
    }
  end

  def render("create.json", params) do
    %{
      response_type: "ephemeral",
      text: "We need permission to use your Spotify.",
      attachments: [
        %{
          "fallback": "<#{params[:url]}|Authenticate with Spotify>",
          "actions": [
            %{
              "type": "button",
              "text": "Authenticate with Spotify",
              "url": "#{params[:url]}"
            }
          ]
        }
      ]
    }
  end
end
