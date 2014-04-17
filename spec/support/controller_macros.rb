module ControllerMacros

  def sign_in_user(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  def mock_oauth(res=oauth_facebook_response)
    OmniAuth.config.add_mock(res["provider"].to_sym, res)
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[res["provider"].to_sym]
  end
end
