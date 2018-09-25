defmodule QmsWeb.AuthView do
  use QmsWeb, :view

  def render("update.json", _params) do
    %{
      response_type: "in_channel",
      text: "It's 80 degrees right now.",
      attachments: [
        %{
          text: "Partly cloudy yesterday and tomorrow"
        }
      ]
    }
  end
end
