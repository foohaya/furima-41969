class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
    super
  end
end
