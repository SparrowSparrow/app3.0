include ApplicationHelper
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  Pony.mail({
                :to => 'you@example.com',
                :via => :sendmail,
                :via_options => {
                    :location  => '/path/to/sendmail', # defaults to 'which sendmail' or '/usr/sbin/sendmail' if 'which' fails
                    :arguments => '-t' # -t and -i are the defaults
                }
            })

end
