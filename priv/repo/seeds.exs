# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Qms.Repo.insert!(%Qms.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Qms.Repo.insert(%Qms.User{slack_user_id: "12345"}, on_conflict: :nothing)
Qms.Repo.insert(%Qms.User{slack_user_id: "23456", status: 0}, on_conflict: :nothing)
