class Users::OmniauthCallbacksController < ApplicationController
  skip_before_action :authenticate_user!

  def facebook
    @user = User.from_omniauth(env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
