site_uri = URI.parse(YAML.load_file("#{RAILS_ROOT}/config/settings.yml")[RAILS_ENV]['site_url'])

ActionMailer::Base.default_url_options[:host] = site_uri.host
ActionMailer::Base.default_url_options[:port] = site_uri.port unless site_uri.port == 80
