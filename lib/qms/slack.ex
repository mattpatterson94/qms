defmodule Qms.Slack do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://hooks.slack.com/services"
  plug Tesla.Middleware.JSON

  def webhook(body) do
    post("<slack url>", body)
  end
end
