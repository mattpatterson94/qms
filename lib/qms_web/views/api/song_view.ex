defmodule QmsWeb.Api.SongView do
  use QmsWeb, :view

  def render("create.json", params) do
    cond do
      params[:type] == :success ->
        cond do
          params[:song] == "" ->
            %{
              response_type: "ephemeral",
              text: "You aren't listening to a song.",
            }
          true ->
            %{
              response_type: "in_channel",
              text: "#{params[:song][:item]["uri"]}",
              attachments: [
                %{
                  pretext: "#{params[:text]}",
                  text: "#{params[:song][:item]["name"]} - #{List.first(params[:song][:item]["artists"])["name"]}",
                }
              ]
            }
        end
      params[:type] == :error ->
        %{
          response_type: "ephemeral",
          text: "You are not authenticated."
        }
      true ->
        %{
          response_type: "ephemeral",
          text: "There was an error with your call. Please try again later."
        }
    end
  end
end