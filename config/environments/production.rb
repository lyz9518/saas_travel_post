# Rottenpotatoes::Application.configure do
#   # Settings specified here will take precedence over those in config/application.rb

#   # Code is not reloaded between requests
#   config.cache_classes = true

#   # Full error reports are disabled and caching is turned on
#   config.consider_all_requests_local       = false
#   config.action_controller.perform_caching = true

#   config.eager_load = true


#   # Disable Rails's static asset server (Apache or nginx will already do this)
#   config.serve_static_files = false

#   # Compress JavaScripts and CSS
#   config.assets.js_compressor = :uglifier

#   # DO fallback to assets pipeline if a precompiled asset is missed
#   config.assets.compile = true

#   # Generate digests for assets URLs
#   config.assets.digest = true

#   # Defaults to Rails.root.join("public/assets")
#   # config.assets.manifest = YOUR_PATH

#   # Specifies the header that your server uses for sending files
#   # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
#   # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

#   # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
#   # config.force_ssl = true

#   # See everything in the log (default is :info)
#   config.log_level = :debug

#   # Use a different logger for distributed setups
#   # config.logger = SyslogLogger.new

#   # Use a different cache store in production
#   # config.cache_store = :mem_cache_store

#   # Enable serving of images, stylesheets, and JavaScripts from an asset server
#   # config.action_controller.asset_host = "http://assets.example.com"

#   # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
#   # config.assets.precompile += %w( search.js )

#   # Disable delivery errors, bad email addresses will be ignored
#   # config.action_mailer.raise_delivery_errors = false

#   # Enable threaded mode
#   # config.threadsafe!

#   # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
#   # the I18n.default_locale when a translation can not be found)
#   config.i18n.fallbacks = true

#   # Send deprecation notices to registered listeners
#   config.active_support.deprecation = :notify
# end

Rottenpotatoes::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite.  You never need to work with it otherwise.  Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs.  Don't rely on the data there!
  config.cache_classes = true

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_files = true
  config.static_cache_control = "public, max-age=3600"
  config.eager_load = false


  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

  # Allow pass debug_assets=true as a query parameter to load pages with unpackaged assets
  config.assets.allow_debugging = true
end
