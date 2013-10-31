Weedout::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # DO care if mailer can't send
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.delivery_method = :smtp

  # Suggested these details go in environtmental variabls
  # http://stevechristie.tumblr.com/post/35158776548/how-to-set-up-local-environmental-variables
  # setting up gmail for devise
  # http://stevechristie.tumblr.com/post/35152797572/setting-up-the-mailer-for-devise
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "gmail.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: "weedoutcolumbia",
    password: "rubyongails"
  }

  # Using localhost 3030 because that's where vagrant port forwards to
  config.action_mailer.default_url_options = { :host => 'localhost:3030' }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
end
