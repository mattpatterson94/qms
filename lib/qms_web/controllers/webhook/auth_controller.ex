defmodule QmsWeb.Webhook.AuthController do
  use QmsWeb, :controller
  alias Qms.{Repo, User}

  # token=gIkuvaNzQIHg97ATvDxqgjtO
  # &team_id=T0001
  # &team_domain=example
  # &enterprise_id=E0001
  # &enterprise_name=Globular%20Construct%20Inc
  # &channel_id=C2147483705
  # &channel_name=test
  # &user_id=U2147483697
  # &user_name=Steve
  # &command=/weather
  # &text=94070
  # &response_url=https://hooks.slack.com/commands/1234/5678
  # &trigger_id=13345224609.738474920.8088930838d88f008e0

  def index(conn, _params) do
    Qms.Slack.webhook(
      %{
        text: "Your Spotify account has been successfully connected to *QMS* :tada:",
        response_type: "ephemeral",
        attachments: [
          %{
          text: "Use `/qms` to start sharing your tracks!"
          }
        ]
      }
    )

    send_resp(conn, :ok, "")
  end
end
