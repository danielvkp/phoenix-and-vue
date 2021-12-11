defmodule Newapp.UserSeacher do
   import Ecto.Query
   alias Newapp.User .{Repo, User}

   def search(params) do
     IO.inspect(params)
     filter(params)
   end


   def filter(params) do
    from(u in Newapp.User, select: u)
      |> maybe_filter_email(params)
      |> Newapp.Repo.paginate(params)
  end

  defp maybe_filter_email(query, %{"email" => email}) do
     where(query, [u], like(u.email, ^"%#{email}%"))
  end

  defp maybe_filter_email(query, %{"page" => page}),
    do: query
end
