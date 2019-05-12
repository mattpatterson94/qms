defmodule Qms.Spotify.SongResponse do
  alias Qms.UriHelper

  def format(song, text) when song == "", do: ""

  def format(song, text) do
    %{
      input: text,
      song: song_name(song),
      artist: artist_name(song),
      album: album_name(song),
      time: current_time(song),
      image_url: image_url(song),
      song_url: song_url(song),
      song_uri: song_uri(song),
      sample_url: sample_url(song)
    }
  end

  # Private

  defp song_name(song) do
    song[:item]["name"]
  end

  defp artist_name(song) do
    List.first(song[:item]["artists"])["name"]
  end

  defp album_name(song) do
    year = Date.from_iso8601!(song[:item]["album"]["release_date"]).year
    album_name = song[:item]["album"]["name"]

    "#{album_name} [#{year}]"
  end

  defp current_time(song) do
    duration = Timex.Duration.to_time!(Timex.Duration.from_milliseconds(song[:progress_ms]))

    "#{duration.minute}:#{Timex.format!(duration, "%S", :strftime)}"
  end

  defp image_url(song) do
    List.first(song[:item]["album"]["images"])["url"]
  end

  defp song_url(song) do
    song[:item]["external_urls"]["spotify"]
  end

  defp song_uri(song) do
    song[:item]["uri"]
  end

  defp sample_url(song) do
    song[:item]["preview_url"]
  end
end
