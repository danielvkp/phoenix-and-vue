defmodule Newapp.Repo do
  use Ecto.Repo,
    otp_app: :newapp,
    adapter: Ecto.Adapters.MyXQL
 use Scrivener, page_size: 10
end
