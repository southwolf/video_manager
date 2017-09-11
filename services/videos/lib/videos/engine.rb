module Videos
  class Engine < ::Rails::Engine
    isolate_namespace Videos
    config.generators.api_only = true

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
