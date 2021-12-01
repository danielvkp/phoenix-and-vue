defmodule Newapp.Guardian.AuthPipeline do
    use Guardian.Plug.Pipeline, otp_app: :Blog,
    module: Newapp.Guardian,
    error_handler: Newapp.AuthErrorHandler

    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
end
