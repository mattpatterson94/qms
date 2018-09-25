defmodule QmsWeb.AuthView do
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
end
