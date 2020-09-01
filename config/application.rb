require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Circles
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.autoload_paths << "#{Rails.root}/app/reports"

    # 以smtp邮件传送协议发送邮件
    config.action_mailer.delivery_method = :smtp
    # 邮件服务器的设置
    config.action_mailer.smtp_settings = {
        :address              => "smtp.gmail.com",
        :port                 => 587,
        :user_name            => 'userName', #不要写成了邮件,比如userName@gamil.com 这个写userName
        :password             =>  "password",
        :authentication       => 'plain',
        :enable_starttls_auto => true
    }
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators do |generator|
      generator.assets false
    end
  end
end
