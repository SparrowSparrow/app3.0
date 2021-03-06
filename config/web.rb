require 'pony'
require 'sinatra/base'

class Application < Sinatra::Base
  configure do
    # ...

    Pony.options = {
        :via => :smtp,
        :via_options => {
            :address => 'smtp.sendgrid.net',
            :port => '587',
            :domain => 'myapp.com',
            :user_name => ENV['SENDGRID_USERNAME'],
            :password => ENV['SENDGRID_PASSWORD'],
            :authentication => :plain,
            :enable_starttls_auto => true
        }
    }
  end

  # ...
end
