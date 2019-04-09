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

alias BirinApi.Rings.RingSerial

user_id =
  BirinApi.Repo.insert!(%BirinApi.Accounts.User{
    auth_id: "abc1",
    email: "joe@smith.com",
    name: "Joe Smith",
    license_number: "ABC1"
  }).id

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

ring_series_id =
  BirinApi.Repo.insert!(%BirinApi.Rings.RingSeries{
    type: "AA",
    size: 100,
    start_number: "ABC001",
    end_number: "ABC101",
    received_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
    allocated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
  }).id

RingSerial.ring_number_stream(100, "ABC001", "ABC101")
|> Stream.each(fn ring_number ->
  BirinApi.Repo.insert!(%BirinApi.Rings.RingNumber{
    type: "AA",
    number: ring_number,
    user_id: user_id,
    ring_series_id: ring_series_id
  })
end)
|> Stream.run()

BirinApi.Repo.insert!(%BirinApi.Rings.RingSeries{
  type: "AA",
  size: 0,
  start_number: "ABC201",
  end_number: "ABC201",
  received_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
  allocated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
}).id
