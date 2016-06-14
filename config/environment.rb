# Load the Rails application.
# require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# ActionMailer::Base.default :content_type => "text/html"
#
# ActionMailer::Base.smtp_settings = {
#     :address        => 'smtp.sendgrid.net',
#     :port           => '587',
#     :authentication => :plain,
#     :user_name      => ENV['SENDGRID_USERNAME'],
#     :password       => ENV['SENDGRID_PASSWORD'],
#     :domain         => 'heroku.com',
#     :enable_starttls_auto => true
# }

# ENV['ENV'] ||= 'development'
#
# db_conf = YAML::load(File.open('config/database.yml'))
#
# DB1_CONF = db_conf["db1"][ENV['ENV']]
# DB2_CONF = db_conf["db2"][ENV['ENV']]