##
# Setup global project settings for your apps.
# These settings are inherited by every subapp. You can override these settings
# in the subapps as needed.
#
Padrino.configure_apps do
    enable :sessions
    # set :session_secret, ENV["SECRET"]
    set :protection, except: :path_traversal
    set :protect_from_csrf, true if RACK_ENV == "production"
    set :server, "puma"
end

# Mounts the core application for this project
Padrino.mount("api", app_class: "Satapi::Api").to("/api/")

# Padrino.configure_apps do
#     use BetterErrors::Middleware
#     BetterErrors.application_root = __dir__
# end
