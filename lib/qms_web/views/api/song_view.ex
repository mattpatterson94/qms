defmodule QmsWeb.Api.SongView do
  use QmsWeb, :view

  def render("show.json", _params) do
    %{
      response_type: "in_channel",
      text: "This is your song.",
    }
  end
end
