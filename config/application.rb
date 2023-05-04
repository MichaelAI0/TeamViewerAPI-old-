require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module TeamViewerAPI
  class Application < Rails::Application
    config.load_defaults 7.0
    config.autoload_paths << Rails.root.join("lib")

    config.before_configuration do
      Dotenv.load
    end

    config.api_only = true
  end
end
