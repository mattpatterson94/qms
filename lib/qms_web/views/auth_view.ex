defmodule QmsWeb.AuthView do
  use QmsWeb, :view

  def render("show.json", _params) do
    %{
      result: "BOB"
    }
  end
end
