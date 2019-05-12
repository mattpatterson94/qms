defmodule QmsWeb.Api.SongView do
  use QmsWeb, :view

  def render("create.json", params = %{type: type, presenter: presenter}) do
    cond do
      type == :success ->
        cond do
          presenter == "" ->
            %{
              response_type: "ephemeral",
              text: "You aren't listening to a song."
            }

          true ->
            %{
              response_type: "in_channel",
              attachments: [
                %{
                    pretext: "#{presenter.input}",
                    color: "#000000",
                    thumb_url: "#{presenter.image_url}",
                    fields: [
                      %{
                        title: "#{presenter.song} - #{presenter.artist}",
                        value: "#{presenter.album}",
                        short: true
                      },
                      %{
                        title: "Time",
                        value: "#{presenter.time}",
                        short: true
                      }
                    ],
                    actions: [
                      %{
                        type: "button",
                        style: "primary",
                        text: "Listen On Spotify",
                        url: "#{presenter.song_url}"
                      },
                      %{
                        type: "button",
                        text: "Sample",
                        url: "#{presenter.sample_url}"
                      }
                    ]
                }
              ]
            }
        end

      type == :authentication ->
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

      type == :error ->
        %{
          response_type: "ephemeral",
          text: "There was an error with your call. Please try again later."
        }
    end
  end
end
