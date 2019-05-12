defmodule QmsWeb.Api.AuthView do
  use QmsWeb, :view

  def render("create.json", params) do
    cond do
      params[:type] == :success ->
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
      params[:type] == :exists ->
        %{
          response_type: "ephemeral",
          text: "You are already authenticated."
        }
      params[:type] == :error ->
        %{
          response_type: "ephemeral",
          text: "There was an error with your call. Please try again later."
        }
      true ->
        %{
          response_type: "ephemeral",
          text: "There was an error with your call. Please try again later."
        }
    end
  end
end
