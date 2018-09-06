defmodule QmsWeb.PageView do
  use QmsWeb, :view

  def render("index.json", _params) do
    %{
      result: "test"
    }
  end
end
