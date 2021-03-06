Rails.application.configure do
  aws_credentials = Aws::Credentials.new(ENV['S3_ACCESS_KEY_ID'], ENV['S3_SECRET_ACCESS_KEY'])
  Aws::Rails.add_action_mailer_delivery_method(:aws_ses, credentials: aws_credentials, region: 'us-west-2')

  config.action_mailer.default_url_options = { host: 'localhost', port: ENV['PORT'] }
  config.action_mailer.delivery_method = :aws_ses
  config.action_mailer.smtp_settings = {
    address: 'email-smtp.us-west-2.amazonaws',
    port: 587,
    domain: 'www.superdev.academy',
    user_name: ENV['SES_USER_NAME'],
    password: ENV['SES_PASSWORD'],
    authentication: :login,
    enable_starttls_auto: true,
  }

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.asset_host = 'https://www.superdev.academy'

  config.paperclip_defaults = {
    storage: :s3,
    s3_credentials: {
      access_key_id: ENV['S3_ACCESS_KEY_ID'],
      secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
      bucket: 'superdev-academy-dev',
      s3_region: 'sa-east-1',
    },
    s3_protocol: :https,
    s3_host_name: 's3-sa-east-1.amazonaws.com',
    region: 'sa-east-1',
    default_url: 'missing.png',
  }

  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker


  config.after_initialize do
    Bullet.enable = true
    Bullet.add_footer = true
    Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
    Bullet.stacktrace_excludes = [ 'their_gem', 'their_middleware' ]
  end

end
