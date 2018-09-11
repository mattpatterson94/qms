defmodule QmsWeb.SongView do
  use QmsWeb, :view

  def render("show.json", _params) do
    %{
      result: "BOB"
    }
  end
end
