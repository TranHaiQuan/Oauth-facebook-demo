class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    data = request.env["omniauth.auth"]
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["facebook_data"] = {
        credentials: request.env["omniauth.auth"].credentials,
        info: request.env["omniauth.auth"].info,
        provider: request.env["omniauth.auth"].provider,
        uid: request.env["omniauth.auth"].uid
      }
      redirect_to new_user_registration_url
    end
  end
end
