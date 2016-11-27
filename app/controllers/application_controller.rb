class ApplicationController < ActionController::API
  before_action do
    puts "user_signed_in?: #{user_signed_in?}"
    p current_user
    puts "access_token: #{request.headers['X-Access-Token']}"
  end
end
