Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Do not eager load code on boot.
  config.eager_load = false

  config.assets.quiet = true

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.cache_classes = true
    config.action_controller.perform_caching = true

    # config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.cache_classes = false
    config.action_controller.perform_caching = false

    # config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

# config.action_mailer.delivery_method = :letter_opener

  config.action_mailer.default_url_options = { host: Setting.domain, protocol: Setting.protocol }

  config.action_mailer.delivery_method   = Setting.mailer_provider.to_sym
  if Setting.mailer_provider == 'postmark'
    config.action_mailer.postmark_settings = Setting.mailer_options.deep_symbolize_keys
  else
    config.action_mailer.smtp_settings = Setting.mailer_options.deep_symbolize_keys
  end
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = false

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.active_job.queue_adapter = :sidekiq
  
end