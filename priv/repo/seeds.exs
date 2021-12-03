# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#

Newapp.User.changeset(%Newapp.User{},
  %{
    email: "danielvkp@live.com",
    password: "admin",
    role: 1
  })
  |> Newapp.Repo.insert!


for _<-1..150 do
  Newapp.User.changeset(%Newapp.User{},
    %{
      email: Faker.Internet.email(),
      password: "admin",
      role: 2
    })
    |> Newapp.Repo.insert!

alias Faker.Internet
end



#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
