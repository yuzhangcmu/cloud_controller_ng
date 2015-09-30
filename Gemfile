# This used to be https, but that causes problems in the vagrant container used by warden-jenkins.
source 'http://rubygems.org'

gem 'addressable'
gem 'activesupport'
gem 'rake'
gem 'eventmachine', '~> 1.0.0'
gem 'fog'
gem 'i18n'
gem 'nokogiri', '~> 1.6.2'
gem 'unf'
gem 'netaddr'
gem 'rfc822'
gem 'sequel'
gem 'sinatra', '~> 1.4'
gem 'sinatra-contrib'
gem 'multi_json'
#gem 'yajl-ruby'
gem 'membrane', '~> 1.0'
gem 'httpclient'
gem 'steno', git: 'https://github.com/suhlig/steno.git', ref: 'f7eda2ecf6e5ba10553a87f6c4980f0635e7f8ba'
gem 'cloudfront-signer'
gem 'vcap_common', '~> 4.0', git: 'https://github.com/MarcSchunk/vcap-common.git', ref:'d8ad8606fdb339215121b4f63d625a42a92d5ffd'
gem 'allowy'
gem 'loggregator_emitter', '~> 4.0'
gem 'delayed_job_sequel', git: 'https://github.com/cloudfoundry/delayed_job_sequel.git'
#gem 'thin', '~> 1.6.0'
gem 'newrelic_rpm', '3.12.0.288'
gem 'clockwork', require: false
gem 'activemodel'
gem 'statsd-ruby'

# We need to use https for git urls as the git protocol is blocked by various
# firewalls
gem 'vcap-concurrency', git: 'https://github.com/cloudfoundry/vcap-concurrency.git', ref: '2a5b0179'
gem 'cf-uaa-lib', '~> 3.1.0', git: 'https://github.com/cloudfoundry/cf-uaa-lib.git', ref: 'b1e11235dc6cd7d8d4680e005526de37201305ea'
gem 'cf-message-bus', '~> 0.3.0', git: 'https://github.com/MarcSchunk/cf-message-bus.git', ref: '4df6f809782db38816cd41f9f9f6e07704dd0a1e'
gem 'cf-registrar', '~> 1.0.2', git: 'https://github.com/cloudfoundry/cf-registrar.git'

group :db do
#  gem 'mysql2', '0.3.20'
  gem 'pg_jruby'
end
