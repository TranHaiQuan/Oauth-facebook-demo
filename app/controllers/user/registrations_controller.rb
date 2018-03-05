class User::RegistrationsController < Devise::RegistrationsController
  def sign_up_params
    param_provider = devise_parameter_sanitizer.sanitize(:sign_up)
    if facebook_data = session["facebook_data"]
      byebug
      param_provider["email"] = facebook_data["info"]["email"]
      param_provider["provider"] = facebook_data["provider"]
      param_provider["uid"] = facebook_data["uid"]
    end
    byebug
    return param_provider
  end
end
