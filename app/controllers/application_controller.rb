class ApplicationController < ActionController::Base
  before_action :basic_auth

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

# PAYJPで使用する環境変数
# PAYJP_PUBLIC_KEY = your_payjp_public_key
# PAYJP_SECRET_KEY = your_payjp_secret_key
end
