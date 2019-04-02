# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BirinApi.Repo.insert!(%BirinApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

BirinApi.Repo.insert!(%BirinApi.Accounts.User{
  auth_id: "abc1",
  email: "joe@smith.com",
  name: "Joe Smith",
  license_number: "ABC1"
})

BirinApi.Repo.insert!(%BirinApi.Accounts.User{
  auth_id: "abc2",
  email: "jane@smith.com",
  name: "Jane Smith",
  license_number: "ABC2"
})

BirinApi.Repo.insert!(%BirinApi.Accounts.User{
  auth_id: "abc3",
  email: "bob@jones.com",
  name: "Bob Jones",
  license_number: "ABC3"
})
